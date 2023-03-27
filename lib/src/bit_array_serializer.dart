import 'package:bit_array/bit_array.dart';
import 'package:json_annotation/json_annotation.dart';

class BitArraySerializer extends JsonConverter<BitArray, String> {
  const BitArraySerializer();

  @override
  BitArray fromJson(String json) {
    return BitArray.parseBinary(json.split('').reversed.join(''));
  }

  @override
  String toJson(BitArray object) {
    return object.toBinaryString();
  }
}
