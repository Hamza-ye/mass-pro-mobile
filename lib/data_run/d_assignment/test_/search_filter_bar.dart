import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:flutter/material.dart';

// class SearchFilterBar extends StatelessWidget {
//   const SearchFilterBar({
//     super.key,
//     required this.onSearchChanged,
//     required this.onStatusChanged,
//     required this.onScopeChanged,
//     required this.onDateRangeChanged,
//     required this.onToggleView,
//     required this.isCardView,
//   });
//
//   final ValueChanged<String> onSearchChanged;
//   final ValueChanged<AssignmentStatus?> onStatusChanged;
//   final ValueChanged<EntityScope?> onScopeChanged;
//   final ValueChanged<DateTimeRange?> onDateRangeChanged;
//   final ValueChanged<bool> onToggleView;
//   final bool isCardView;
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       alignment: WrapAlignment.spaceBetween,
//       children: [
//         IconButton(
//           tooltip: 'Toggle between List and Card view',
//           icon: Icon(isCardView ? Icons.view_list : Icons.view_module),
//           onPressed: () {
//             onToggleView(!isCardView);
//           },
//         ),
//         SizedBox(
//           width: 200,
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'Search...',
//               prefixIcon: Icon(Icons.search),
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: () => onSearchChanged(''),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             onChanged: onSearchChanged,
//           ),
//         ),
//         FilterChip(
//           label: Text('Status'),
//           onSelected: (isSelected) {
//             // Open a dropdown/modal for detailed filtering
//           },
//         ),
//         FilterChip(
//           label: Text('Scope'),
//           onSelected: (isSelected) {
//             // Open a dropdown/modal for detailed filtering
//           },
//         ),
//         IconButton(
//           tooltip: 'Select Date Range',
//           icon: Icon(Icons.date_range),
//           onPressed: () async {
//             final DateTimeRange? picked = await showDateRangePicker(
//               context: context,
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2101),
//             );
//             onDateRangeChanged(picked);
//           },
//         ),
//         TextButton.icon(
//           onPressed: () {
//             // Clear all filters logic
//           },
//           icon: Icon(Icons.clear_all),
//           label: Text('Clear Filters'),
//         ),
//       ],
//     );
//   }
// }

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
        // Toggle View Button
        IconButton(
          icon: Icon(isCardView ? Icons.view_list : Icons.view_module),
          onPressed: () {
            onToggleView(!isCardView);
          },
        ),
        const SizedBox(width: 8),
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
      ],
    );
  }
}
