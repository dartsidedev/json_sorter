import 'package:json_sorter/src/bin/pubspec_info.dart' as info;
import 'package:test/test.dart';

void main() {
  group('pubspec info', () {
    test('has description', () {
      expect(info.description, isNotEmpty);
    });

    test('has home page', () {
      expect(info.homepage, isNotEmpty);
    });

    test('has issue tracker', () {
      expect(info.issueTracker, isNotEmpty);
    });

    test('has name', () {
      expect(info.name, isNotEmpty);
    });

    test('has version', () {
      expect(info.version, isNotEmpty);
    });
  });
}
