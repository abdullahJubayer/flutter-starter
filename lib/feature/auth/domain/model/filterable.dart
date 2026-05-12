abstract class Filterable {
  String getFilterKey();

  bool matcher(String query, {bool ignoreCase = true}) {
    final key = getFilterKey();
    if (ignoreCase) {
      return key.toLowerCase().contains(query.toLowerCase());
    } else {
      return key.contains(query);
    }
  }
}
