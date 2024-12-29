import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentOverviewItem extends ConsumerWidget {
  const AssignmentOverviewItem({
    super.key,
    required this.assignment,
    required this.onSubmitForm,
    required this.onViewDetails,
    required this.onChangeStatus,
  });

  final AssignmentModel assignment;
  final VoidCallback onSubmitForm;
  final VoidCallback onViewDetails;
  final void Function(AssignmentStatus newStatus) onChangeStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery =
        ref.watch(filterQueryProvider.select((value) => value.searchQuery));
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Activity and Assignment ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildHighlightedText(
                      assignment.activity, searchQuery, context),
                ),
                _buildStatusBadge(),
              ],
            ),
            const SizedBox(height: 8),
            // Text('Assignment ID: $assignmentId',
            //     style: Theme.of(context).textTheme.bodySmall, softWrap: true),
            _buildDetailRow(
              context,
              icon: Icons.category,
              label: 'Scope',
              value: assignment.scope.name,
              style: TextStyle(color: Colors.grey[700]),
            ),

            const Divider(height: 20),

            // Details Section
            _buildDetailIcon(
                Icons.location_on,
                '${assignment.entityCode} - ${assignment.entityName}',
                searchQuery,
                context),
            const SizedBox(height: 8),
            _buildDetailIcon(
                Icons.group, assignment.teamName, searchQuery, context),
            const SizedBox(height: 16),

            _buildDetailRow(
              context,
              icon: Icons.calendar_today,
              label: 'dueDate',
              value: _formatDate(assignment.dueDate, context),
              style: assignment.dueDate.isBefore(DateTime.now())
                  ? Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.red)
                  : Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey[700]),
            ),

            if (assignment.rescheduledDate != null)
              _buildDetailIcon(
                Icons.calendar_view_day,
                _formatDate(assignment.rescheduledDate!, context),
                searchQuery,
                context,
              ),
            const Divider(height: 20),

            // Forms Section
            Text(
              'Forms: ${assignment.forms.length}',
              style: Theme.of(context).textTheme.labelMedium,
              softWrap: true,
            ),

            const SizedBox(height: 16),
            // Resources Section
            _buildResourcesComparison(context),

            const SizedBox(height: 16),

            // Actions Section
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: onSubmitForm,
                        icon: const Icon(Icons.send),
                        label: const Text(
                          'Submit Form',
                          softWrap: true,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: onViewDetails,
                        icon: const Icon(Icons.info_outline),
                        label: const Text('View Details', softWrap: true),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 20),
                DropdownButton<AssignmentStatus>(
                  onChanged: (value) {
                    if (value != null) onChangeStatus(value);
                  },
                  value: assignment.status,
                  items: AssignmentStatus.values
                      .map((status) => DropdownMenuItem<AssignmentStatus>(
                            value: status,
                            child: Text(
                              status.name,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(
      String text, String searchQuery, BuildContext context) {
    if (searchQuery.isEmpty) {
      return Text(text, softWrap: true);
    }

    final matches = RegExp(searchQuery, caseSensitive: false).allMatches(text);
    if (matches.isEmpty) {
      return Text(text, softWrap: true);
    }

    final List<TextSpan> spans = [];
    int start = 0;

    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: const TextStyle(backgroundColor: Colors.yellow),
      ));
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text:
          TextSpan(style: DefaultTextStyle.of(context).style, children: spans),
    );
  }

  Widget _buildDetailIcon(
      IconData icon, String value, String searchQuery, BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 4),
        _buildHighlightedText(value, searchQuery, context),
      ],
    );
  }

  Widget _buildResourcesComparison(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resources',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        ...assignment.allocatedResources.keys.map((key) {
          final allocated = assignment.allocatedResources[key] ?? 0;
          final reported = assignment.reportedResources[key] ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '$reported / $allocated',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context,
      {required IconData icon,
      required String label,
      required String value,
      String searchQuery = '',
      TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text('$label:', style: style, softWrap: true),
          const SizedBox(width: 8),
          Expanded(
            child: _buildHighlightedText(value, searchQuery, context),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    IconData statusIcon;
    Color badgeColor;

    switch (assignment.status) {
      case AssignmentStatus.NOT_STARTED:
        statusIcon = Icons.hourglass_empty;
        badgeColor = Colors.grey;
        break;
      case AssignmentStatus.IN_PROGRESS:
        statusIcon = Icons.autorenew;
        badgeColor = Colors.blue;
        break;
      case AssignmentStatus.COMPLETED:
        statusIcon = Icons.check_circle;
        badgeColor = Colors.green;
        break;
      case AssignmentStatus.RESCHEDULED:
        statusIcon = Icons.schedule;
        badgeColor = Colors.orange;
        break;
      case AssignmentStatus.CANCELLED:
        statusIcon = Icons.cancel;
        badgeColor = Colors.red;
        break;
      default:
        statusIcon = Icons.help_outline;
        badgeColor = Colors.black;
    }

    return Tooltip(
      message: assignment.status.name,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(statusIcon, color: Colors.white),
      ),
    );
  }

  String _formatDate(DateTime date, BuildContext context) {
    return MaterialLocalizations.of(context).formatFullDate(date);
  }
}
