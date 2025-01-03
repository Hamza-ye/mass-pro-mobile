import 'package:datarun/data_run/d_assignment/assign_over/assignmens_map_view.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_detail/assignment_detail_page.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_table_view.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignments_card_view.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/search_filter_bar.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentPage extends ConsumerWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Toggle View Button
          IconButton(
            icon: Icon(
              ref.watch(filterQueryProvider.select((value) => value.isCardView))
                  ? Icons.table_chart
                  : Icons.view_agenda,
            ),
            onPressed: () {
              ref.read(filterQueryProvider.notifier).toggleCardTableView();
            },
          ),
        ],
      ),
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SearchFilterBar(
          onSearchChanged: (query) =>
              ref.read(filterQueryProvider.notifier).updateSearchQuery(query),
          onStatusChanged: (status) => ref
              .read(filterQueryProvider.notifier)
              .updateFilter('status', status),
          onScopeChanged: (scope) => ref
              .read(filterQueryProvider.notifier)
              .updateFilter('scope', scope),
          onDayChanged: (day) {
            ref.read(filterQueryProvider.notifier).updateFilter('days', [day]);
          },
          onClearFilters: () => ref
              .read(filterQueryProvider.notifier)
              .clearAllFilters(),
          isCardView: ref
              .watch(filterQueryProvider.select((value) => value.isCardView)),
          onTeamChanged: (String? team) {
            ref
                .read(filterQueryProvider.notifier)
                .updateFilter('teams', [team]);
          },
        ),
      ),
      body: _buildAssignmentList(context, ref),
    );
  }

  Widget _buildAssignmentList(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      switchInCurve: Curves.bounceOut,
      duration: const Duration(milliseconds: 300),
      child: ref.watch(filterQueryProvider.select((value) => value.isCardView))
          ? AssignmentsCardView(
              key: const ValueKey('cardView'),
              onViewDetails: (assignment) =>
                  _navigateToDetails(context, assignment),
            )
          : AssignmentTableView(
              key: const ValueKey('tableView'),
              onViewDetails: (assignment) =>
                  _navigateToDetails(context, assignment),
            ),
    );
  }

  Widget _buildDraggableMap(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          child: AssignmentMapPage(),
        );
      },
    );
  }

  void _navigateToDetails(BuildContext context, AssignmentModel assignment) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AssignmentDetailPage(assignment: assignment),
      ),
    );
  }
}
