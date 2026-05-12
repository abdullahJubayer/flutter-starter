import 'filter_state.dart';

mixin BaseFilterController {
  late FilterState state;

  void setStartDate(DateTime? date) {
    state = state.copyWith(startDate: date);
  }

  void setEndDate(DateTime? date) {
    state = state.copyWith(endDate: date);
  }

  void setDateRange({DateTime? startDate, DateTime? endDate}) {
    state = state.copyWith(startDate: startDate, endDate: endDate);
  }

  void reset() {
    state = FilterState.empty;
  }
}
