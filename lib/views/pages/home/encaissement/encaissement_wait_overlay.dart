import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/mock/mock_repository.dart';
import 'package:fripay/providers/mock_providers.dart';

const Duration demoEncaissementWait = Duration(seconds: 20);

/// File d’attente mock puis résultat aléatoire ([termine] / [echec]) pour tester la relance.
Future<void> runEncaissementProcessingDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String encId,
  bool setEnCoursFirst = false,
}) async {
  if (setEnCoursFirst) {
    ref.read(encaissementsProvider.notifier).updateStatus(encId, 'en_cours');
  }
  await showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 280),
    pageBuilder: (_, __, ___) => _EncaissementWaitOverlay(
      onDone: () {
        Navigator.of(context).pop();
        final success = MockRepository.instance.randomEncaissementOutcome();
        ref.read(encaissementsProvider.notifier).updateStatus(
              encId,
              success ? 'termine' : 'echec',
            );
      },
    ),
  );
}

class _EncaissementWaitOverlay extends StatefulWidget {
  const _EncaissementWaitOverlay({required this.onDone});

  final VoidCallback onDone;

  @override
  State<_EncaissementWaitOverlay> createState() =>
      _EncaissementWaitOverlayState();
}

class _EncaissementWaitOverlayState extends State<_EncaissementWaitOverlay> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    final start = DateTime.now();
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(milliseconds: 120));
      if (!mounted) return false;
      final elapsed = DateTime.now().difference(start);
      setState(() {
        _progress = (elapsed.inMilliseconds / demoEncaissementWait.inMilliseconds)
            .clamp(0.0, 1.0);
      });
      return elapsed < demoEncaissementWait;
    }).then((_) {
      if (mounted) {
        setState(() => _progress = 1);
        Future<void>.delayed(const Duration(milliseconds: 400)).then((_) {
          if (mounted) widget.onDone();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.hourglass_top_rounded, size: 56),
              const SizedBox(height: 20),
              Text(
                'Traitement de l’encaissement',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Connexion au réseau mobile… Ne fermez pas l’application.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                    ),
              ),
              const SizedBox(height: 28),
              LinearProgressIndicator(value: _progress),
              const SizedBox(height: 12),
              Text(
                '${(_progress * 100).round()} %',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
