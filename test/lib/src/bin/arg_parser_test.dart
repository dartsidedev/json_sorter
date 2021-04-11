import 'package:json_sorter/src/bin/arg_parser.dart';
import 'package:test/test.dart';

void main() {
  group('$parser', () {
    test('can create usage', () {
      expect(parser.usage, isNotEmpty);
    });

    group('has option for', () {
      test('space-indent', () {
        expect(parser.options['space-indent'], isNotNull);
      });

      test('tab-indent', () {
        expect(parser.options['tab-indent'], isNotNull);
      });

      test('verbose', () {
        expect(parser.options['verbose'], isNotNull);
      });

      test('help', () {
        expect(parser.options['help'], isNotNull);
      });

      test('version', () {
        expect(parser.options['version'], isNotNull);
      });
    });
  });
}
