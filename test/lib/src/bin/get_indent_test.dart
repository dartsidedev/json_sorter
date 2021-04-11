import 'package:json_sorter/src/bin/get_indent.dart';
import 'package:test/test.dart';

void main() {
  group('$getIndent', () {
    test('returns null if neither spaces nor tabs are set', () {
      expect(getIndent(null, null), null);
    });

    test('throws if both spaces and tabs are set', () {
      expect(() => getIndent(5, true), throwsArgumentError);
    });

    test('returns 4 spaces if spaces is set to 4', () {
      expect(getIndent(4, null), '    ');
    });

    test('returns 2 spaces if spaces is set to 2', () {
      expect(getIndent(2, null), '  ');
    });

    test('returns tab if tab is set to true', () {
      expect(getIndent(null, true), '\t');
    });

    test('throws if tab is set to false', () {
      expect(() => getIndent(null, false), throwsArgumentError);
    });
  });
}
