import 'package:test/test.dart';

import '../../bin/json_sorter.dart';

void main() {
  group('$parseArguments', () {
    test('single file as path', () {
      const arguments = [
        'somefile.json',
      ];

      final ac = parseArguments(arguments);

      expect(ac.paths, hasLength(1));
      expect(ac.paths.first, 'somefile.json');
    });

    test('multiple files as path', () {
      const arguments = [
        'somefile1.json',
        'somefile2.json',
        'somefile3.json',
      ];

      final ac = parseArguments(arguments);

      expect(ac.paths, hasLength(3));
      expect(ac.paths[0], 'somefile1.json');
      expect(ac.paths[1], 'somefile2.json');
      expect(ac.paths[2], 'somefile3.json');
    });

    test('single file with long verbose flag', () {
      const arguments = [
        '--verbose',
        'somefile.json',
      ];

      final ac = parseArguments(arguments);

      expect(ac.paths, hasLength(1));
      expect(ac.paths.first, 'somefile.json');
      expect(ac.verbose, true);
    });

    test('single file with short verbose flag', () {
      const arguments = [
        '-v',
        'somefile.json',
      ];

      final ac = parseArguments(arguments);

      expect(ac.paths, hasLength(1));
      expect(ac.paths.first, 'somefile.json');
      expect(ac.verbose, true);
    });

    test('single file with tab indent', () {
      const arguments = [
        '--tab-indent',
        'somefile.json',
      ];

      final ac = parseArguments(arguments);

      expect(ac.paths, hasLength(1));
      expect(ac.paths.first, 'somefile.json');
      expect(ac.tabIndent, true);
      expect(ac.spaceIndent, null);
    });

    test('multiple files, verbose, 4 space indent (spaces)', () {
      const arguments = [
        '--verbose',
        '--space-indent',
        '4',
        'somefile1.json',
        'somefile2.json',
      ];

      final ac = parseArguments(arguments);

      expect(ac.paths, hasLength(2));
      expect(ac.paths.first, 'somefile1.json');
      expect(ac.paths.last, 'somefile2.json');
      expect(ac.verbose, true);
      expect(ac.spaceIndent, 4);
      expect(ac.tabIndent, null);
    });
  });

  group('$buildIndent', () {
    test('4 spaces', () {
      expect(buildIndent(4, null), '    ');
    });

    test('2 spaces', () {
      expect(buildIndent(2, null), '  ');
    });

    test('tab', () {
      expect(buildIndent(null, true), '\t');
    });

    test('none', () {
      expect(buildIndent(null, null), null);
    });

    test('throws if both spaces and tabs are set', () {
      expect(() => buildIndent(4, true), throwsA(anything));
      expect(() => buildIndent(4, false), throwsA(anything));
    });
  });
}
