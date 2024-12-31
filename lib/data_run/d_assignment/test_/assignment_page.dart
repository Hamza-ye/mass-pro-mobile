import 'package:datarun/data_run/d_assignment/assign_over/assignment_detail_page.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_table_view.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignments_card_view.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/active_filters_widget.dart';
import 'package:datarun/data_run/d_assignment/test_/search_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentPage extends ConsumerWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final filterQuery = ref.watch(filterQueryProvider);
    // final isCardView = filterQuery.isCardView;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Assignments'),
      // ),
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
          onDateRangeChanged: (range) {
            // ref.read(filterQueryProvider.notifier).updateSelectedDateRange(range);
          },
          onToggleView: (isCard) => ref
              .read(filterQueryProvider.notifier)
              .toggleCardTableView(isCard),
          isCardView: ref
              .watch(filterQueryProvider.select((value) => value.isCardView)),
        ),
      ),
      body: AnimatedSwitcher(
        switchInCurve: Curves.bounceOut,
        // switchOutCurve: Curves.bounceOut,
        duration: const Duration(milliseconds: 300),
        child:
            ref.watch(filterQueryProvider.select((value) => value.isCardView))
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
      ),
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

// class AssignmentPage extends ConsumerWidget {
//   const AssignmentPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final filterQuery = ref.watch(filterQueryProvider);
//     final isCardView = filterQuery.isCardView;
//
//     ref.watch(filterQueryProvider);
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           SizedBox(
//             width: 200,
//             child: TextFormField(
//               initialValue: filterQuery.searchQuery,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: Icon(Icons.search),
//                 suffixIcon: ref
//                         .watch(filterQueryProvider
//                             .select((value) => value.searchQuery))
//                         .isNotEmpty
//                     ? IconButton(
//                         icon: Icon(Icons.clear),
//                         onPressed: () => ref
//                             .read(filterQueryProvider.notifier)
//                             .updateSearchQuery(''),
//                       )
//                     : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               onChanged: (searchQuery) {
//                 ref.read(filterQueryProvider.notifier).updateSearchQuery(
//                       searchQuery,
//                     );
//               },
//             ),
//           ),
//           IconButton(
//             tooltip: 'Toggle between List and Card view',
//             icon: Icon(ref.watch(
//                     filterQueryProvider.select((value) => value.isCardView))
//                 ? Icons.view_list
//                 : Icons.view_module),
//             onPressed: () {
//               // onToggleView(!isCardView);
//               ref.read(filterQueryProvider.notifier).toggleCardTableView(
//                   !ref.watch(
//                       filterQueryProvider.select((value) => value.isCardView)));
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.filter_alt),
//             onPressed: () {
//               showFilterBottomSheet(
//                 context,
//                 [
//                   FilterModel(
//                       label: 'Team',
//                       options: ['Team A', 'Team B'],
//                       isMultiSelect: true),
//                   FilterModel(
//                       label: 'Status', options: ['Active', 'Completed']),
//                   FilterModel(
//                       label: 'Priority', options: ['High', 'Medium', 'Low']),
//                 ],
//                 (selectedFilters) {
//                   // ref
//                   //     .read(filterQueryProvider.notifier).updateFilter(filterKey, filterValue);
//                 },
//               );
//             },
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           // if (activeFilters.isNotEmpty)
//           ActiveFiltersWidget(
//             activeFilters: ref.watch(filterQueryProvider).filters,
//             onClearAll: () {
//               ref.read(filterQueryProvider.notifier).clearAllFilters();
//             },
//             onRemoveFilter: (filterKey) {
//               ref.read(filterQueryProvider.notifier).removeFilter(filterKey);
//             },
//           ),
//
//           Expanded(
//             child: ref.watch(
//                     filterQueryProvider.select((value) => value.isCardView))
//                 ? AssignmentsCardView(
//                     key: const ValueKey('cardView'),
//                     onViewDetails: (assignment) {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               AssignmentDetailPage(assignment: assignment),
//                         ),
//                       );
//                     },
//                   )
//                 : AssignmentTableView(
//                     key: const ValueKey('tableView'),
//                     onViewDetails: (assignment) {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               AssignmentDetailPage(assignment: assignment),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void showFilterBottomSheet(
//       BuildContext context, List<FilterModel> filters, Function onApply) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             final Map<String, dynamic> selectedFilters = {};
//
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Filters',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 16.0),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: filters.length,
//                       itemBuilder: (context, index) {
//                         final filter = filters[index];
//                         return ExpansionTile(
//                           title: Text(filter.label),
//                           children: [
//                             Wrap(
//                               spacing: 8.0,
//                               children: filter.options.map((option) {
//                                 final isSelected = selectedFilters[filter.label]
//                                         ?.contains(option) ??
//                                     false;
//                                 return ChoiceChip(
//                                   label: Text(option),
//                                   selected: isSelected,
//                                   onSelected: (selected) {
//                                     setState(() {
//                                       selectedFilters[filter.label] ??= [];
//                                       if (selected) {
//                                         selectedFilters[filter.label]
//                                             .add(option);
//                                       } else {
//                                         selectedFilters[filter.label]
//                                             .remove(option);
//                                       }
//                                     });
//                                   },
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedFilters.clear();
//                           });
//                         },
//                         child: Text('Reset'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           onApply(selectedFilters);
//                           Navigator.pop(context);
//                         },
//                         child: Text('Apply'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class AssignmentPage extends ConsumerWidget {
//   const AssignmentPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       bottomNavigationBar: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: SearchFilterBar(
//           onSearchChanged: (query) {
//             ref.read(filterQueryProvider.notifier).updateSearchQuery(query);
//           },
//           onStatusChanged: (status) {
//             ref.read(filterQueryProvider.notifier).updateSelectedStatus(status);
//           },
//           onScopeChanged: (scope) {
//             ref.read(filterQueryProvider.notifier).updateSelectedScope(scope);
//           },
//           onDateRangeChanged: (range) {
//             // ref.read(filterQueryProvider.notifier).updateSelectedDateRange(range);
//           },
//           onToggleView: (isCard) {
//             ref.read(filterQueryProvider.notifier).toggleCardTableView(isCard);
//           },
//           isCardView: ref
//               .watch(filterQueryProvider.select((value) => value.isCardView)),
//         ),
//       ),
//       body: ref.watch(filterQueryProvider.select((value) => value.isCardView))
//           ? AssignmentsCardView(
//         onViewDetails: (assignment) {
//           // Navigate to details.
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) =>
//                   AssignmentDetailPage(assignment: assignment),
//             ),
//           );
//         },
//       )
//           : AssignmentTableView(
//         onViewDetails: (assignment) {
//           // Navigate to details.
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) =>
//                   AssignmentDetailPage(assignment: assignment),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
