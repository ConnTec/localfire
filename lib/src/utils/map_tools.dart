Map<String, dynamic> deepMergeMap(
    Map<String, dynamic> source, Map<String, dynamic> changes) {
  changes.forEach((k, v) {
    if (source.containsKey(k) && changes[k] is Map && source[k] is Map) {
      deepMergeMap(source[k], changes[k]);
    } else {
      source[k] = v;
    }
  });

  return source;
}
