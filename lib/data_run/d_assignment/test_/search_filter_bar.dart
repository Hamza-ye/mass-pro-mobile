import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    super.key,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onScopeChanged,
    required this.onDateRangeChanged,
    required this.onToggleView,
    required this.isCardView,
  });

  final ValueChanged<String> onSearchChanged;
  final ValueChanged<AssignmentStatus?> onStatusChanged;
  final ValueChanged<EntityScope?> onScopeChanged;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;
  final ValueChanged<bool> onToggleView;
  final bool isCardView;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Search Bar
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            constraints: BoxConstraints(maxWidth: 200, maxHeight: 40),
          ),
          onChanged: onSearchChanged,
        ),
        const SizedBox(width: 8),
        // Status Filter
        DropdownButton<AssignmentStatus>(
          hint: Text(
            'Status',
            softWrap: true,
          ),
          onChanged: onStatusChanged,
          items: AssignmentStatus.values.map((AssignmentStatus value) {
            return DropdownMenuItem<AssignmentStatus>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
        ),
        const SizedBox(width: 8),
        // Scope Filter
        DropdownButton<EntityScope>(
          hint: Text(
            'Scope',
            softWrap: true,
          ),
          onChanged: onScopeChanged,
          items: EntityScope.values.map((EntityScope value) {
            return DropdownMenuItem<EntityScope>(
              value: value,
              child: Text(
                value.name,
                softWrap: true,
              ),
            );
          }).toList(),
        ),
        const SizedBox(width: 8),
        // Date Range Filter
        IconButton(
          icon: Icon(Icons.date_range),
          onPressed: () async {
            final DateTimeRange? picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            onDateRangeChanged(picked);
          },
        ),
        const SizedBox(width: 8),
        // Toggle View Button
        IconButton(
          icon: Icon(isCardView ? Icons.view_list : Icons.view_module),
          onPressed: () {
            onToggleView(!isCardView);
          },
        ),
      ],
    );
  }
}
