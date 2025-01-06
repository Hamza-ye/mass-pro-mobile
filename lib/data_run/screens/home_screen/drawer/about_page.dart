import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(S.of(context).appInformation,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            leading:
                Icon(Icons.info_outline, ),
            title: Text(S.of(context).appVersion),
            subtitle: Text('1.0.3'),
          ),
        ),
        const SizedBox(height: 24),
        // Card(
        //   child: ListTile(
        //     leading:
        //         Icon(MdiIcons.server, ),
        //     title: Text(S.of(context).serverUrl),
        //     subtitle: Text(sessionInfo.sessionData?.serverUrl ?? '-'),
        //   ),
        // ),
        const SizedBox(height: 24),
        Text(S.of(context).developerInformation,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: Icon(Icons.developer_mode,
                ),
            title: Text(S.of(context).developer),
            subtitle: Text(S.of(context).developerInfoText),
          ),
        ),
        // Card(
        //   child: ListTile(
        //     leading: Icon(MdiIcons.github, ),
        //     title: Text('GitHub'),
        //     subtitle: Text('https://github.com/DataRun-ye'),
        //     onTap: () {
        //       // TODO(Hamza) Handle link tap
        //     },
        //   ),
        // ),
      ],
    );
  }
}
