import 'package:flutter/material.dart';
import 'package:fripay/gen/assets.gen.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/theme/app_theme.dart';
import 'package:fripay/views/routes.dart';
import 'package:fripay/views/utils/globalwidget/buttons/clickable.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return GeneralScaffold(
      content: LayoutBuilder(
        builder: (context, constraints) {
          final h = constraints.maxHeight;
          final horizontal = 20.0;
          final topPad = (h * 0.06).clamp(28.0, 72.0);
          final bottomPad = (h * 0.06).clamp(24.0, 56.0);
          final minChildHeight = (h - topPad - bottomPad).clamp(0.0, double.infinity);

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(horizontal, topPad, horizontal, bottomPad),
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minChildHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Assets.images.logoFripaySvg.svg(
                      height: 52,
                      fit: BoxFit.contain,
                      semanticsLabel: 'FinanfaSend',
                    ),
                  ),
                  SizedBox(height: (h * 0.03).clamp(14.0, 28.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.waving_hand_rounded,
                        color: scheme.secondary.withValues(alpha: 0.9),
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${l10n.home1} Joel',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              l10n.home2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: scheme.onSurface
                                        .withValues(alpha: 0.64),
                                    height: 1.5,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: (h * 0.05).clamp(20.0, 40.0)),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.05,
                    children: [
                      _HomeTile(
                        iconSvg: Assets.icones.homeEncaisser,
                        label: l10n.encaisser,
                        accent: const Color(0xFF059669),
                        onTap: () => context.pushNamed(RoutesNames.Encaisser),
                      ),
                      _HomeTile(
                        iconSvg: Assets.icones.transfer,
                        label: l10n.payer,
                        accent: scheme.primary,
                        onTap: () => context.pushNamed(RoutesNames.Payer),
                      ),
                      _HomeTile(
                        iconSvg: Assets.icones.homeCartes,
                        label: l10n.home4,
                        accent: const Color(0xFF6366F1),
                        onTap: () => context.pushNamed(RoutesNames.AddCarte),
                      ),
                      _HomeTile(
                        iconSvg: Assets.icones.profile,
                        label: l10n.home,
                        accent: const Color(0xFF7C3AED),
                        onTap: () => context.pushNamed(RoutesNames.Profil),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  const _HomeTile({
    required this.iconSvg,
    required this.label,
    required this.accent,
    required this.onTap,
  });

  final SvgGenImage iconSvg;
  final String label;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Clickable(
      onClick: onTap,
      child: Material(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: scheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: iconSvg.svg(
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(accent, BlendMode.srcIn),
                ),
              ),
              const Spacer(),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
              ),
              const SizedBox(height: 4),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: scheme.onSurface.withValues(alpha: 0.38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
