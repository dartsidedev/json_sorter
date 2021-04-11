import 'package:json_sorter/src/bin/arg_parser.dart';
import 'package:json_sorter/src/bin/help.dart';
import 'package:test/test.dart';

void main() {
  group('help', () {
    test('returns a non-empty string', () {
      expect(help, isNotEmpty);
    });

    test('contains package name', () {
      expect(help, contains('json_sorter'));
    });

    test('contains short description', () {
      expect(help, contains('DESCRIPTION'));
    });

    test('contains usage info', () {
      expect(help, contains('USAGE'));
    });

    test('contains examples', () {
      expect(help, contains('EXAMPLES'));
    });

    test('contains options documentation', () {
      expect(help, contains('OPTIONS'));
      expect(help, contains(parser.usage));
    });
  });
}
