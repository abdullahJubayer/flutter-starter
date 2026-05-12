import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LifecycleManager extends ConsumerStatefulWidget {
  final Widget child;

  const LifecycleManager({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<LifecycleManager> createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends ConsumerState<LifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // App is visible and responding to user input
        _handleAppResumed();
        break;
      case AppLifecycleState.paused:
        // App is not currently visible to the user, but is still running
        break;
      case AppLifecycleState.inactive:
        // App is in an inactive state and not receiving user input
        break;
      case AppLifecycleState.detached:
        // App is still hosted on the Flutter engine but is detached from any host views
        break;
      case AppLifecycleState.hidden:
        // App is not visible to the user
        break;
    }
  }

  Future<void> _handleAppResumed() async {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: widget.child,
    );
  }
}
