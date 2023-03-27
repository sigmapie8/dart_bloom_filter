import 'dart:math';

import 'package:bit_array/bit_array.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:murmurhash/murmurhash.dart';

import 'bit_array_serializer.dart';
import 'bloom_filter_base.dart';

part 'bloom_filter.g.dart';

@JsonSerializable()
class BloomFilter<T> extends BloomFilterBase<T> {
  @BitArraySerializer()
  late BitArray bitArray;

  /// total size of the bit array
  late int arraySize;

  /// seed to be used for the hashing algorithm
  late int hashSeed;

  /// sets to true if murmur hash is being used
  bool murmur = false;

  /// number of elements add to the filter since generation
  int numberOfElements = 0;

  /// number of elements user is expecting to add to the filter
  final int expectedNumberOfElements;

  /// expected false positive rate
  final double falsePositiveProbability;

  int numberOfHashes = 1;

  late double konstant;

  /// Returns the number of elements add to the filter since generation
  int get length => numberOfElements;

  /// Returns the total size of the bit array in the filter
  int get size => arraySize;

  BloomFilter(this.expectedNumberOfElements, this.falsePositiveProbability) {
    // ceil(-log2(false prob))
    numberOfHashes =
        ((-(log(falsePositiveProbability) / log(2))).ceil()).toInt();

    // k/log(2)
    konstant = (-(log(falsePositiveProbability) / log(2))).ceil() / log(2);

    arraySize = (konstant * expectedNumberOfElements).ceil();

    bitArray = BitArray(arraySize);
  }

  /// Bloom Filter that uses murmur hashing algorithm
  BloomFilter.murmur(this.expectedNumberOfElements,
      this.falsePositiveProbability, this.hashSeed) {
    // ceil(-log2(false prob))
    numberOfHashes =
        ((-(log(falsePositiveProbability) / log(2))).ceil()).toInt();

    // k/log(2)
    konstant = (-(log(falsePositiveProbability) / log(2))).ceil() / log(2);

    arraySize = (konstant * expectedNumberOfElements).ceil();

    bitArray = BitArray(arraySize);
    murmur = true;
  }

  /// sets the required bit to true
  @override
  void add({required T item}) {
    bitArray.setBit(getHash(item: item) % arraySize);
    numberOfElements++;
  }

  /// returns false if the element is definitely not in among the added
  /// elements, returns true if it might be contained
  @override
  bool contains({required T item}) {
    return bitArray[getHash(item: item) % arraySize];
  }

  /// resets all bits to false
  @override
  void clear() {
    bitArray.clearAll();
    numberOfElements = 0;
  }

  @override
  void addAll({required List<T> items}) {
    for (T item in items) {
      bitArray.setBit(getHash(item: item) % arraySize);
      numberOfElements++;
    }
  }

  /// [getHash] supports two methods for creating hashes:
  /// 1. Dart's default - <object>.hashCode
  /// 2. MurmurHash - It uses a combination of <object>.toString()
  /// and <object>.hashCode to as an input to murmur hash algo
  int getHash({required T item}) {
    if (murmur) {
      return MurmurHash.v3(
          item.toString() + item.hashCode.toString(), hashSeed);
    } else {
      return item.hashCode;
    }
  }

  factory BloomFilter.fromJson(Map<String, dynamic> json) =>
      _$BloomFilterFromJson(json);

  Map<String, dynamic> toJson() => _$BloomFilterToJson(this);
}
