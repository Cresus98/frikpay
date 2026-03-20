
import 'package:flutter/material.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  double balance = 1500.75;
  late AnimationController _pulseController;
  late AnimationController _popController;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();


    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);


    _popController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );


    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _popController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'fr_FR', symbol: '€');

    return GeneralScaffold(
    content: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // Carte avec shimmer
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: balance),
              duration: const Duration(seconds: 2),
              onEnd: () => _popController.forward(from: 0),
              builder: (context, value, child) {
                return AnimatedBuilder(
                  animation: _shimmerController,
                  builder: (context, _) {
                    final shimmerPosition =
                        _shimmerController.value * 2 - 1;
                    return ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          begin: Alignment(-1, -1),
                          end: Alignment(1, 1),
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.0),
                          ],
                          stops: [
                            (shimmerPosition - 0.3).clamp(0.0, 1.0),
                            shimmerPosition.clamp(0.0, 1.0),
                            (shimmerPosition + 0.3).clamp(0.0, 1.0),
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0061FF), Color(0xFF60EFFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Solde disponible",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(height: 10),

                            // Rebond sur le montant
                            ScaleTransition(
                              scale: Tween<double>(begin: 1, end: 1.1)
                                  .chain(CurveTween(curve: Curves.elasticOut))
                                  .animate(_popController),
                              child: Text(
                                formatter.format(value),
                                style: const TextStyle(
                                  fontSize: 34,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 40),

            // Bouton avec effet de pulse
            ScaleTransition(
              scale: _pulseController,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Recharge en cours...")),
                  );
                },
                icon: const Icon(Icons.add_circle_outline, size: 24),
                label: const Text(
                  "Recharger",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}
