import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';

class AssignmentDetailPage extends StatelessWidget {
  const AssignmentDetailPage({super.key, required this.assignment});

  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assignment Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildDetails(context),
            const SizedBox(height: 16),
            _buildResourcesComparison(context),
            const SizedBox(height: 16),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            assignment.activity,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        _buildStatusBadge(context),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(context, 'Entity',
            '${assignment.entityCode} - ${assignment.entityName}'),
        _buildDetailRow(
            context, 'Team', '${assignment.teamCode} - ${assignment.teamName}'),
        _buildDetailRow(context, 'Scope', assignment.scope.name),
        _buildDetailRow(context, 'Due Date', assignment.dueDate.toString()),
        if (assignment.rescheduledDate != null)
          _buildDetailRow(context, 'Rescheduled Date',
              assignment.rescheduledDate.toString()),
        _buildDetailRow(context, 'Forms', assignment.forms.length.toString()),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildResourcesComparison(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Resources', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        ...assignment.allocatedResources.keys.map((key) {
          final allocated = assignment.allocatedResources[key] ?? 0;
          final reported = assignment.reportedResources[key] ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(key, style: Theme.of(context).textTheme.bodyMedium),
              Text('$reported / $allocated',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Handle form submission
          },
          icon: const Icon(Icons.send),
          label: const Text('Submit Form'),
        ),
        const SizedBox(height: 8),
        DropdownButton<AssignmentStatus>(
          onChanged: (value) {
            if (value != null) {
              // Handle status change
            }
          },
          value: assignment.status,
          items: AssignmentStatus.values.map((status) {
            return DropdownMenuItem<AssignmentStatus>(
              value: status,
              child: Text(status.name),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _statusColor(assignment.status),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        assignment.status.name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Color _statusColor(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.NOT_STARTED:
        return Colors.grey;
      case AssignmentStatus.IN_PROGRESS:
        return Colors.blue;
      case AssignmentStatus.COMPLETED:
        return Colors.green;
      case AssignmentStatus.RESCHEDULED:
        return Colors.orange;
      case AssignmentStatus.CANCELLED:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
