import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_activity/activity_card.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_activity/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/d_assignment/test_/assignment_page.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(activitiesProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Activities')),
      body: AsyncValueWidget(
        value: activitiesAsync,
        valueBuilder: (List<ActivityModel> activities) {
          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ActivityCard(
                activity: activity,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ActivityInheritedWidget(
                          activityModel: activity, child: AssignmentPage()),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
