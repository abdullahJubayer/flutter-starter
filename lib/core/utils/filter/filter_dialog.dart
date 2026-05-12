import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/utils/filter/provider/filter_notifier.dart';
import 'package:flutter_template/core/utils/filter/provider/filter_state.dart';
import 'package:flutter_template/core/widget/custom_dialog.dart';

class FilterDialog extends ConsumerWidget {
  final dynamic provider;
  final String title;

  const FilterDialog({super.key, this.provider, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Global users
    final userFilter = ref.watch(filterProvider);
    final userNotifier = ref.read(filterProvider.notifier);

    late dynamic activeController;
    late FilterState activeState;

    if (provider != null) {
      activeController = ref.read(provider.notifier);
      activeState = ref.watch(provider);
    } else {
      activeController = ref.read(filterProvider.notifier);
      activeState = ref.watch(filterProvider);
    }

    return CustomDialog(
      title: 'title',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Users'),
          if (userFilter.users.isEmpty)
            ElevatedButton(
              onPressed: () => userNotifier.getUsers(),
              child: const Text('Load Users'),
            )
          else
            ...userFilter.users.map((u) => Text(u)),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => activeController.setStartDate(DateTime.now()),
            child: const Text('Set Start Date'),
          ),
          TextButton(
            onPressed: () => activeController.setEndDate(
              DateTime.now().add(const Duration(days: 7)),
            ),
            child: const Text('Set End Date'),
          ),
          Text('Start: ${activeState.startDate}'),
          Text('End: ${activeState.endDate}'),
        ],
      ),
    );
  }
}
