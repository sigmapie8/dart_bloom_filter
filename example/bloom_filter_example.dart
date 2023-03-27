import 'package:bloom_filter/src/bloom_filter.dart';

void main() {
  final items = [
    'roti',
    'kapda',
    'makaan',
    'credit card',
    'wifi',
    'snacks',
    'ghar ki roti',
    'bahar ki boti'
  ];

  final bloomy = BloomFilter.murmur(10, 0.001, 12345);

  for (String item in items) {
    print('Before Adding: is $item added? ${bloomy.contains(item: item)}');
    bloomy.add(item: item);
    print('After Adding: is $item added? ${bloomy.contains(item: item)}');
  }
}
