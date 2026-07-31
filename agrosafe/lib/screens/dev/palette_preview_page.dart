import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Throwaway developer screen: renders every design token as a swatch so the
/// consolidated palette can be verified visually on a device/emulator.
///
/// To view it, temporarily set `home: const PalettePreviewPage()` in app.dart,
/// or push it from any button. Not part of the shipped user flow.
class PalettePreviewPage extends StatelessWidget {
  const PalettePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tokens = <_Token>[
      _Token('primary', AppColors.primary),
      _Token('primaryDark', AppColors.primaryDark),
      _Token('primaryLight', AppColors.primaryLight),
      _Token('primarySurface', AppColors.primarySurface),
      _Token('amber', AppColors.amber),
      _Token('onAmber', AppColors.onAmber),
      _Token('amberSurface', AppColors.amberSurface),
      _Token('error', AppColors.error),
      _Token('errorDark', AppColors.errorDark),
      _Token('errorSurface', AppColors.errorSurface),
      _Token('textPrimary', AppColors.textPrimary),
      _Token('textSecondary', AppColors.textSecondary),
      _Token('textTertiary', AppColors.textTertiary),
      _Token('textMuted', AppColors.textMuted),
      _Token('border', AppColors.border),
      _Token('borderStrong', AppColors.borderStrong),
      _Token('background', AppColors.background),
      _Token('highContrastYellow', AppColors.highContrastYellow),
      _Token('womenCircleAccent', AppColors.womenCircleAccent),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Palette preview')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tokens.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final t = tokens[i];
          return Row(
            children: [
              Container(
                width: 64,
                height: 48,
                decoration: BoxDecoration(
                  color: t.color,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  t.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Token {
  final String name;
  final Color color;
  const _Token(this.name, this.color);
}
