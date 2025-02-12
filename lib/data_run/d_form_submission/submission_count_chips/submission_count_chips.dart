import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/core/common/state.dart';
import 'package:datarun/data_run/d_form_submission/submission_count_chips/submission_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CountChip extends ConsumerWidget {
  const CountChip({super.key, required this.syncStatus});

  final SyncStatus syncStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countSync = ref.watch(submissionsSyncStateCountProvider(syncStatus));

    return AsyncValueWidget(
      value: countSync,
      valueBuilder: (count) => Chip(
        shadowColor: Theme.of(context).colorScheme.shadow,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        avatar: buildStatusIcon(syncStatus),
        //Icon(icon, size: 18, color: Theme.of(context).primaryColor),
        label: Row(
          children: [
            Text('$count ', style: Theme.of(context).textTheme.bodyMedium),
            Text('${Intl.message(syncStatus.name.toLowerCase())}',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        backgroundColor: Theme.of(context).chipTheme.backgroundColor,
      ),
    );
  }

  Widget buildStatusIcon(SyncStatus? status) {
    switch (status) {
      case SyncStatus.SYNCED:
        return const Icon(Icons.cloud_done, color: Colors.green, size: 18);
      case SyncStatus.TO_POST:
        return const Icon(Icons.cloud_upload, color: Colors.blue, size: 18);
      case SyncStatus.TO_UPDATE:
        return const Icon(Icons.update, color: Colors.orange, size: 18);
      case SyncStatus.ERROR:
        return const Icon(Icons.error, color: Colors.red, size: 18);
      default:
        return const Icon(Icons.all_inclusive, size: 18);
    }
  }
}
