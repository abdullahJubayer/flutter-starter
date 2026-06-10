import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/widget/custom_button.dart';
import 'package:safe_device/safe_device.dart';

/// A gate that performs basic device security checks at startup in release mode.
/// If any risk is detected, it blocks the application UI and shows a warning.
class SecurityGate extends StatefulWidget {
  final Widget child;

  const SecurityGate({super.key, required this.child});

  @override
  State<SecurityGate> createState() => _SecurityGateState();
}

class _SecurityGateState extends State<SecurityGate> {
  bool _loading = true;
  bool _blocked = true;
  List<String> _reasons = const [];

  @override
  void initState() {
    super.initState();
    _runChecks();
  }

  Future<void> _runChecks() async {
    // Only enforce in release mode, allow pass-through in debug/profile.
    if (!kReleaseMode) {
      setState(() {
        _loading = false;
        // _blocked = false;
      });
      return;
    }

    final reasons = <String>[];

    try {
      // Root/Jailbreak detection
      final jailBroken = await SafeDevice.isJailBroken;
      if (jailBroken) {
        reasons.add('This device appears to be rooted/jailbroken.');
      }
    } catch (_) {
      // On error, do not block by default; just ignore this particular check.
    }

    try {
      // Emulator/Simulator detection: isRealDevice returns false if running on emulator.
      final isReal = await SafeDevice.isRealDevice;
      if (!isReal) {
        reasons.add('The app is running on an emulator/simulator.');
      }
    } catch (_) {}

    try {
      // Developer mode status (primarily Android).
      if (Platform.isAndroid) {
        final devMode = await SafeDevice.isDevelopmentModeEnable;
        if (devMode) {
          reasons.add('Developer options are enabled on this device.');
        }
      }
    } catch (_) {}

    try {
      // Mock location status (Android only).
      if (Platform.isAndroid) {
        final mockLoc = await SafeDevice.isMockLocation;
        if (mockLoc) {
          reasons.add('Mock location is enabled on this device.');
        }
      }
    } catch (_) {}

    if (!mounted) return;
    setState(() {
      _loading = false;
      _blocked = reasons.isNotEmpty;
      _reasons = reasons;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      // Keep a minimal splash-like progress to avoid flicker only in release when checking.
      return const Material(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_blocked) {
      return _SecurityWarningScreen(reasons: _reasons, onRetry: _runChecks);
    }

    return widget.child;
  }
}

class _SecurityWarningScreen extends StatelessWidget {
  final List<String> reasons;
  final Future<void> Function() onRetry;

  const _SecurityWarningScreen({required this.reasons, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 48,
                        color: theme.colorScheme.error,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Security warning',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'For your safety, the app is unavailable on this device configuration. The following risks were detected:',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ...reasons.map(
                    (r) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0, right: 8.0),
                            child: Icon(Icons.circle, size: 8),
                          ),
                          Expanded(
                            child: Text(r, style: theme.textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(onPressed: () => onRetry(), label: 'Retry'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'If you believe this is a mistake, please contact support after ensuring developer options are disabled and mock location is off. Avoid using rooted or jailbroken devices.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
