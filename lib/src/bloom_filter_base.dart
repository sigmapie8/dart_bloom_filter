
abstract class BloomFilterBase<T> {
  void add({required T item});
  void addAll({required List<T> items});
  bool contains({required T item});
  void clear();
}
