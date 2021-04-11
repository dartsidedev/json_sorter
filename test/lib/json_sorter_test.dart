import 'package:json_sorter/json_sorter.dart';
import 'package:test/test.dart';

void main() {
  group('$JsonSortedEncoder', () {
    test('encodes with the map keys sorted', () {
      final encoder = JsonSortedEncoder();
      expect(
        encoder.convert(inputMap),
        sortedJsonOutput,
      );
    });

    test('encodes with the map keys sorted with indent', () {
      final encoder = JsonSortedEncoder.withIndent('  ');
      expect(
        encoder.convert(inputMap),
        indentedSortedJsonOutput,
      );
    });
  });

  group('$jsonSortedEncode', () {
    test('encodes with the map keys sorted', () {
      expect(
        jsonSortedEncode(inputMap),
        sortedJsonOutput,
      );
    });
  });
}

const inputMap = {
  'xxx': {
    'r': 'r',
    'rr': 'rr',
    'q': 'q',
  },
  'abba': {
    'z': {
      'n': 1,
      's': 'f',
      'l': [],
      'm': {},
      'b': true,
    },
    'a': 1,
    'zz': 'zz',
    'bl': [true, true, false, false, null],
  },
  'baab': null,
  'aaa': [1, 1, 1],
};

const sortedJsonOutput =
    '{"aaa":[1,1,1],"abba":{"a":1,"bl":[true,true,false,false,null],"z":{"b":true,"l":[],"m":{},"n":1,"s":"f"},"zz":"zz"},"baab":null,"xxx":{"q":"q","r":"r","rr":"rr"}}';

const indentedSortedJsonOutput = '''{
  "aaa": [
    1,
    1,
    1
  ],
  "abba": {
    "a": 1,
    "bl": [
      true,
      true,
      false,
      false,
      null
    ],
    "z": {
      "b": true,
      "l": [],
      "m": {},
      "n": 1,
      "s": "f"
    },
    "zz": "zz"
  },
  "baab": null,
  "xxx": {
    "q": "q",
    "r": "r",
    "rr": "rr"
  }
}''';
