import 'package:datarun/generated/l10n.dart';
import 'package:datarun/main_constants/main_constants.dart';
import 'package:datarun/utils/app_appearance.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppearanceSettingsTab extends ConsumerWidget {
  const AppearanceSettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        ListTile(
          title: Text(S.of(context).toggleBrightness),
          trailing: Switch(
            value: Theme.of(context).brightness == Brightness.light,
            onChanged: (value) {
              ref
                  .read(appAppearanceNotifierProvider.notifier)
                  .handleBrightnessChange(value);
            },
          ),
        ),
        ListTile(
          title: Text('Material Version'),
          trailing: IconButton(
            icon: Theme.of(context).useMaterial3
                ? Icon(
                    Icons.filter_2,
                  )
                : Icon(
                    Icons.filter_3,
                  ),
            onPressed: () => ref
                .read(appAppearanceNotifierProvider.notifier)
                .handleMaterialVersionChange(),
          ),
        ),
        ListTile(
          title: Text(S.of(context).selectColorTheme),
          trailing: const _ColorSeedButton(),
        ),
        ListTile(
          title: Text(S.of(context).selectImageForColorExtraction),
          trailing: const _ColorImageButton(),
        ),
      ],
    );
  }
}

class _ColorSeedButton extends ConsumerWidget {
  const _ColorSeedButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      icon: Icon(
        Icons.palette_outlined,
      ),
      tooltip: S.of(context).selectASeedColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSeed.values.length, (index) {
          ColorSeed currentColor = ColorSeed.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentColor !=
                    ref.watch(appAppearanceNotifierProvider).colorSelected ||
                ref.watch(appAppearanceNotifierProvider).colorSelectionMethod !=
                    ColorSelectionMethod.colorSeed,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    currentColor ==
                                ref
                                    .watch(appAppearanceNotifierProvider)
                                    .colorSelected &&
                            ref
                                    .watch(appAppearanceNotifierProvider)
                                    .colorSelectionMethod !=
                                ColorSelectionMethod.image
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected:
          ref.read(appAppearanceNotifierProvider.notifier).handleColorSelect,
    );
  }
}

class _ColorImageButton extends ConsumerWidget {
  const _ColorImageButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      icon: Icon(
        Icons.image_outlined,
      ),
      tooltip: S.of(context).selectAColorExtractionImage,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorImageProvider.values.length, (index) {
          final currentImageProvider = ColorImageProvider.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentImageProvider !=
                    ref.watch(appAppearanceNotifierProvider).imageSelected ||
                ref.watch(appAppearanceNotifierProvider).colorSelectionMethod !=
                    ColorSelectionMethod.image,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 48),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          image: NetworkImage(currentImageProvider.url),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentImageProvider.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected:
          ref.read(appAppearanceNotifierProvider.notifier).handleImageSelect,
    );
  }
}

// class _BrightnessButton extends ConsumerWidget {
//   const _BrightnessButton({
//     this.showTooltipBelow = true,
//   });
//
//   final bool showTooltipBelow;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isBright = Theme.of(context).brightness == Brightness.light;
//     return Tooltip(
//       preferBelow: showTooltipBelow,
//       message: S.of(context).toggleBrightness,
//       child: IconButton(
//         icon: isBright
//             ? const Icon(Icons.dark_mode_outlined)
//             : const Icon(Icons.light_mode_outlined),
//         onPressed: () => ref
//             .read(appAppearanceNotifierProvider.notifier)
//             .handleBrightnessChange(!isBright),
//       ),
//     );
//   }
// }
