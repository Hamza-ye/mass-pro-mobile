import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({required this.activity, required this.onTap, super.key});

  final ActivityModel activity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activity.activity!.name!,
                  style: Theme.of(context).textTheme.titleMedium),
              if (activity.assignedTeam?.name != null)
                Text(
                    '${S.of(context).assignedTeam}: ${activity.assignedTeam!.name}'),
              const SizedBox(height: 8.0),
              Divider(height: 20.0),
              Text(
                  '${S.of(context).managedTeams}: ${activity.managedTeams.length}'),
              Text(
                  '${S.of(context).assignedAssignments}: ${activity.assignedAssignments}'),
              Text(
                  '${S.of(context).managedAssignments}: ${activity.managedAssignments}'),
              if (activity.activity?.properties['startDate'] != null)
                Text(
                    '${S.of(context).startDate}: ${formatDateString(activity.activity!.properties['startDate'], context)}'),
              if (activity.activity?.properties['endDate'] != null)
                Text(
                    '${S.of(context).endDate}: ${formatDateString(activity.activity?.properties['endDate'], context)}'),
            ],
          ),
        ),
      ),
    );
  }
}

String formatDate(DateTime date, BuildContext context) {
  return MaterialLocalizations.of(context).formatFullDate(date);
}

String formatDateString(String date, BuildContext context) {
  final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", 'en_US');
  final formatedDate = dateFormat.parse(date);
  return MaterialLocalizations.of(context).formatFullDate(formatedDate);
}
