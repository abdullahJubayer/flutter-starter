import 'package:flutter_template/feature/auth/domain/model/filterable.dart';

class SearchUtil {
  static List<T> find<T extends Filterable>({
    required List<T> items,
    required String query,
    SearchFilter<T>? filter,
    bool ignoreCase = true,
  }) {
    final preFiltered = filter != null ? items.where(filter) : items;
    return preFiltered
        .where((item) => item.matcher(query, ignoreCase: ignoreCase))
        .toList();
  }
}

typedef SearchFilter<T> = bool Function(T item);
