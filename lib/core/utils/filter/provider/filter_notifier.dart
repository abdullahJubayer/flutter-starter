import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'base_filter_controller.dart';
import 'filter_state.dart';

part 'filter_notifier.g.dart';

@Riverpod(keepAlive: true)
class FilterNotifier extends _$FilterNotifier with BaseFilterController {
  @override
  FilterState build() {
    return FilterState.empty;
  }

  void getUsers() async {
    state = state.copyWith(users: ['user1', 'user2', 'user3']);
  }
}
