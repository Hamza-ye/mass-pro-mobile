import 'package:datarun/data_run/d_assignment/assign_over/assignment_detail_page.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_table_view.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignments_card_view.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/search_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentPage extends ConsumerWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SearchFilterBar(
          onSearchChanged: (query) {
            ref.read(filterQueryProvider.notifier).updateSearchQuery(query);
          },
          onStatusChanged: (status) {
            ref.read(filterQueryProvider.notifier).updateSelectedStatus(status);
          },
          onScopeChanged: (scope) {
            ref.read(filterQueryProvider.notifier).updateSelectedScope(scope);
          },
          onDateRangeChanged: (range) {
            // ref.read(filterQueryProvider.notifier).updateSelectedDateRange(range);
          },
          onToggleView: (isCard) {
            ref.read(filterQueryProvider.notifier).toggleCardTableView(isCard);
          },
          isCardView: ref
              .watch(filterQueryProvider.select((value) => value.isCardView)),
        ),
      ),
      body: ref.watch(filterQueryProvider.select((value) => value.isCardView))
          ? AssignmentsCardView(
              onViewDetails: (assignment) {
                // Navigate to details.
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AssignmentDetailPage(assignment: assignment),
                  ),
                );
              },
            )
          : AssignmentTableView(
              onViewDetails: (assignment) {
                // Navigate to details.
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AssignmentDetailPage(assignment: assignment),
                  ),
                );
              },
            ),
    );
  }
}
