import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AssignmentOverviewItem extends StatelessWidget {
  final String assignmentId;
  final String activity;
  final String entityCode;
  final String entityName;
  final String teamName;
  final String scope;
  final String status;
  final DateTime dueDate;
  final DateTime? rescheduledDate;
  final List<String> forms;
  final VoidCallback onSubmitForm;
  final VoidCallback onViewDetails;
  final void Function(String newStatus) onChangeStatus;

  const AssignmentOverviewItem({
    Key? key,
    required this.assignmentId,
    required this.activity,
    required this.entityCode,
    required this.entityName,
    required this.teamName,
    required this.scope,
    required this.status,
    required this.dueDate,
    this.rescheduledDate,
    required this.forms,
    required this.onSubmitForm,
    required this.onViewDetails,
    required this.onChangeStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  child: Text(activity,
                      style: Theme.of(context).textTheme.titleMedium,
                      softWrap: true),
                ),
                _buildStatusBadge(),
              ],
            ),
            const SizedBox(height: 8),
            Text('Assignment ID: $assignmentId',
                style: Theme.of(context).textTheme.bodySmall, softWrap: true),

            const Divider(height: 20),

            // Details Section
            _buildDetailRow(
              icon: Icons.location_on,
              label: 'Entity',
              value: '$entityCode - $entityName',
            ),
            _buildDetailRow(
              icon: Icons.group,
              label: 'Team',
              value: teamName,
            ),
            _buildDetailRow(
              icon: Icons.category,
              label: 'Scope',
              value: scope,
            ),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: 'Due Date',
              value: _formatDate(dueDate, context),
              valueColor: dueDate.isBefore(DateTime.now())
                  ? Colors.red
                  : Theme.of(context).textTheme.bodyMedium!.color,
            ),
            if (rescheduledDate != null)
              _buildDetailRow(
                icon: Icons.calendar_view_day,
                label: 'Rescheduled',
                value: _formatDate(rescheduledDate!, context),
              ),

            const Divider(height: 20),

            // Forms Section
            Text(
              'Forms:',
              style: Theme.of(context).textTheme.labelMedium,
              softWrap: true,
            ),
            ...forms.map((form) => Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Text('• $form', softWrap: true),
                )),

            const SizedBox(height: 16),

            // Actions Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
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
                  DropdownButton<String>(
                    onChanged: (value) {
                      if (value != null) onChangeStatus(value);
                    },
                    value: status,
                    items: ['NOT_STARTED', 'IN_PROGRESS', 'COMPLETED']
                        .map((status) => DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value,
                style: TextStyle(color: valueColor), softWrap: true, overflow: TextOverflow.fade,),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    IconData statusIcon;
    Color badgeColor;

    switch (status) {
      case 'NOT_STARTED':
        statusIcon = Icons.hourglass_empty;
        badgeColor = Colors.grey;
        break;
      case 'IN_PROGRESS':
        statusIcon = Icons.autorenew;
        badgeColor = Colors.blue;
        break;
      case 'COMPLETED':
        statusIcon = Icons.check_circle;
        badgeColor = Colors.green;
        break;
      case 'RESCHEDULED':
        statusIcon = Icons.schedule;
        badgeColor = Colors.orange;
        break;
      case 'CANCELLED':
        statusIcon = Icons.cancel;
        badgeColor = Colors.red;
        break;
      default:
        statusIcon = Icons.help_outline;
        badgeColor = Colors.black;
    }

    return Tooltip(
      message: status,
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
