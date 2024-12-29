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
          ? AssignmentsCardView()
          : AssignmentTableView(
              onViewDetails: (assignment) {
                // Navigate to details.
              },
            ),
    );
  }
}

class FiltersWidget extends StatelessWidget {
  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onScopeChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;

  FiltersWidget({
    required this.onStatusChanged,
    required this.onScopeChanged,
    required this.onDateRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.start,
      children: [
        // Status Filter
        DropdownButton<String>(
          hint: const Text('Select Status'),
          items: [
            'NOT_STARTED',
            'IN_PROGRESS',
            'COMPLETED',
            'RESCHEDULED',
            'CANCELLED',
          ]
              .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ))
              .toList(),
          onChanged: onStatusChanged,
        ),
        // Scope Filter
        DropdownButton<String>(
          hint: const Text('Select Scope'),
          items: ['Assigned', 'Managed']
              .map((scope) => DropdownMenuItem(
                    value: scope,
                    child: Text(scope),
                  ))
              .toList(),
          onChanged: onScopeChanged,
        ),
        // Date Range Filter
        ElevatedButton(
          onPressed: () async {
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            onDateRangeChanged(picked);
          },
          child: const Text('Select Date Range'),
        ),
      ],
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onSearch;

  SearchBarWidget({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search by Activity, Entity, or Team',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: onSearch,
    );
  }
}

class Assignment {
  final String id;
  final String activity;
  final String entityCode;
  final String entityName;
  final String teamName;
  final String scope;
  final String status;
  final DateTime dueDate;
  final DateTime? rescheduledDate;
  final Map<String, int> allocatedResources; // E.g., ITNs, Population
  final List<String> forms;

  Assignment({
    required this.id,
    required this.activity,
    required this.entityCode,
    required this.entityName,
    required this.teamName,
    required this.scope,
    required this.status,
    required this.dueDate,
    this.rescheduledDate,
    required this.allocatedResources,
    required this.forms,
  });
}
