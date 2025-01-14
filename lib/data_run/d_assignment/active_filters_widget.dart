import 'package:flutter/material.dart';

class ActiveFiltersWidget extends StatelessWidget {
  const ActiveFiltersWidget({
    required this.activeFilters,
    required this.onClearAll,
    required this.onRemoveFilter,
    super.key,
  });

  final Map<String, dynamic> activeFilters;
  final VoidCallback onClearAll;
  final Function(String) onRemoveFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          for (var entry in activeFilters.entries)
            Chip(
              label: Text('${entry.key}: ${entry.value}'),
              deleteIcon: Icon(Icons.close),
              onDeleted: () => onRemoveFilter(entry.key),
            ),
          if (activeFilters.isNotEmpty)
            ActionChip(
              label: Text('Clear All'),
              onPressed: onClearAll,
            ),
        ],
      ),
    );
  }
}

class FilterModel {
  FilterModel({
    required this.label,
    required this.options,
    this.isMultiSelect = false,
    this.icon,
  });

  final String label;
  final List<String> options;
  final bool isMultiSelect;
  final IconData? icon;
}
