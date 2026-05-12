class FilterState {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<dynamic> users;

  const FilterState({this.startDate, this.endDate, this.users = const []});

  FilterState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<dynamic>? users,
  }) {
    return FilterState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      users: users ?? this.users,
    );
  }

  static const empty = FilterState();
}
