import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralScaffold extends ConsumerWidget {
  final Widget content;
  final Color? backgroundColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool useSafeArea;

  const GeneralScaffold({
    super.key,
    required this.content,
    this.scaffoldKey,
    this.backgroundColor,
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final body = useSafeArea ? SafeArea(child: content) : content;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      body: body,
    );
  }
}
