import 'package:d2_remote/modules/datarun/form/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_detail/assignment_detail_page.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_table_view.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignments_card_view.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/search_filter_bar.dart';
import 'package:datarun/data_run/screens/form/element/form_metadata.dart';
import 'package:datarun/data_run/screens/form/form_tab_screen.widget.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AssignmentPage extends HookConsumerWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _tabController = useTabController(initialLength: 2);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Toggle View Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  ref.watch(filterQueryProvider
                          .select((value) => value.isCardView))
                      ? Icons.table_chart
                      : Icons.view_agenda,
                ),
                onPressed: () {
                  ref.read(filterQueryProvider.notifier).toggleCardTableView();
                },
              ),
            ],
          ),

          // ElevatedButton.icon(
          //   icon: Icon(Icons.all_inbox),
          //   onPressed: () {
          //
          //   },
          //   label: Text(S.of(context).allSubmissions),
          // ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SearchFilterBar(
              onSearchChanged: (query) => ref
                  .read(filterQueryProvider.notifier)
                  .updateSearchQuery(query),
              onStatusChanged: (status) => ref
                  .read(filterQueryProvider.notifier)
                  .updateFilter('status', status),
              onDayChanged: (day) {
                ref
                    .read(filterQueryProvider.notifier)
                    .updateFilter('days', [day]);
              },
              onClearFilters: () =>
                  ref.read(filterQueryProvider.notifier).clearAllFilters(),
              isCardView: ref.watch(
                  filterQueryProvider.select((value) => value.isCardView)),
              onTeamChanged: (String? team) {
                ref
                    .read(filterQueryProvider.notifier)
                    .updateFilter('teams', [team]);
              },
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: S.of(context).assigned),
              Tab(text: S.of(context).managed),
            ],
            onTap: (index) {
              final scope =
                  index == 0 ? EntityScope.Assigned : EntityScope.Managed;
              ref
                  .read(filterQueryProvider.notifier)
                  .updateFilter('scope', scope);
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAssignmentList(context, ref, EntityScope.Assigned),
          _buildAssignmentList(context, ref, EntityScope.Managed),
        ],
      ),
    );
  }

  Widget _buildAssignmentList(
      BuildContext context, WidgetRef ref, EntityScope? scope) {
    return AnimatedSwitcher(
      switchInCurve: Curves.bounceOut,
      duration: const Duration(milliseconds: 300),
      child: ref.watch(filterQueryProvider.select((value) => value.isCardView))
          ? AssignmentsCardView(
              key: const ValueKey('cardView'),
              scope: scope,
              onViewDetails: (assignment) =>
                  _navigateToDetails(context, assignment),
            )
          : AssignmentTableView(
              key: const ValueKey('tableView'),
              scope: scope,
              onViewDetails: (assignment) =>
                  _navigateToDetails(context, assignment),
            ),
    );
  }

  // Widget _buildDraggableMap(BuildContext context, WidgetRef ref) {
  //   return DraggableScrollableSheet(
  //     initialChildSize: 0.5,
  //     minChildSize: 0.2,
  //     maxChildSize: 0.8,
  //     builder: (BuildContext context, ScrollController scrollController) {
  //       return Container(
  //         color: Colors.white,
  //         child: AssignmentMapPage(),
  //       );
  //     },
  //   );
  // }

  void _navigateToDetails(BuildContext context, AssignmentModel assignment) {
    final activityModel = ActivityInheritedWidget.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActivityInheritedWidget(
            activityModel: activityModel,
            child: AssignmentDetailPage(assignment: assignment)),
      ),
    );
  }
}

Widget buildStatusBadge(AssignmentStatus status) {
  IconData statusIcon;
  Color badgeColor;

  switch (status) {
    case AssignmentStatus.NOT_STARTED:
      statusIcon = MdiIcons.progressClock; // More expressive icon
      badgeColor = Colors.grey;
      break;
    case AssignmentStatus.IN_PROGRESS:
      statusIcon = MdiIcons.circleSlice6; // More expressive icon
      badgeColor = Colors.blue;
      break;
    case AssignmentStatus.DONE:
      statusIcon = MdiIcons.checkCircle; // More expressive icon
      badgeColor = Colors.green;
      break;
    case AssignmentStatus.RESCHEDULED:
      statusIcon = MdiIcons.calendarArrowRight; // More expressive icon
      badgeColor = Colors.orange;
      break;
    case AssignmentStatus.CANCELLED:
      statusIcon = MdiIcons.bookCancel; // More expressive icon
      badgeColor = Colors.red;
      break;
    case AssignmentStatus.MERGED:
      statusIcon = MdiIcons.merge; // More expressive icon
      badgeColor = Colors.blueGrey;
      break;
    case AssignmentStatus.REASSIGNED:
      statusIcon = MdiIcons.clipboardAccount; // More expressive icon
      badgeColor = Colors.deepPurpleAccent;
      break;
    default:
      statusIcon = MdiIcons.helpCircleOutline; // More expressive icon
      badgeColor = Colors.black;
  }

  // return Badge(
  //   child: Icon(statusIcon, color: Colors.white),
  //   textColor: badgeColor,
  // );

  return Tooltip(
    message: Intl.message(status.name.toLowerCase()),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(statusIcon, color: Colors.white),
    ),
  );
}

Color? statusColor(AssignmentStatus? status) {
  switch (status) {
    case AssignmentStatus.IN_PROGRESS:
      return Colors.greenAccent.withOpacity(0.5);
    case AssignmentStatus.DONE:
      return null;
    case AssignmentStatus.CANCELLED:
    case AssignmentStatus.MERGED:
    case AssignmentStatus.REASSIGNED:
      return Colors.orangeAccent.withOpacity(0.5);
    case AssignmentStatus.NOT_STARTED:
    case AssignmentStatus.RESCHEDULED:
      return Colors.grey.withOpacity(0.3);
    default:
      return Colors.grey.withOpacity(0.3);

  }
}

Future<void> goToDataEntryForm(BuildContext context, AssignmentModel assignment,
    DataFormSubmission submission, ActivityModel activityModel) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ActivityInheritedWidget(
                activityModel: activityModel,
                child: FormMetadataWidget(
                  formMetadata: FormMetadata(
                    assignmentModel: assignment,
                    formId: submission.formVersion is String
                        ? submission.formVersion
                        : submission.formVersion.id,
                    submission: submission.id,
                  ),
                  child: const FormSubmissionScreen(currentPageIndex: 1),
                ),
              )));
}
