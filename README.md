<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Bloom Filter

A Dart implementation of a bloom filter. [Bloom filters](https://en.wikipedia.org/wiki/Bloom_filter) are a space-efficient probabilistic data structure that is used to test whether an element is a member of a set.


## Usage

```dart
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
```

## Features

* Supports false positive probability control
* Supports [Murmur hash](https://en.wikipedia.org/wiki/MurmurHash)
* Supports Serialization

