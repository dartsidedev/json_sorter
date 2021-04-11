import 'package:json_sorter/src/bin/arguments_container.dart';
import 'package:test/test.dart';

void main() {
  group('$ArgumentsContainer', () {
    group('toString', () {
      test('converts space-indent container to string', () {
        expect(
          ArgumentsContainer(
            paths: [
              'path1.json',
              'path2.json',
              'path3.json',
            ],
            spaceIndent: 4,
            verbose: true,
            help: false,
            version: false,
          ).toString(),
          'ArgumentsContainer(paths: [path1.json, path2.json, path3.json], spaceIndent: 4, tabIndent: null, verbose: true, help: false, version: false)',
        );
      });

      test('converts tab-indent container to string', () {
        expect(
          ArgumentsContainer(
            paths: [
              'path1.json',
              'path2.json',
              'path3.json',
            ],
            tabIndent: true,
            verbose: true,
            help: false,
            version: false,
          ).toString(),
          'ArgumentsContainer(paths: [path1.json, path2.json, path3.json], spaceIndent: null, tabIndent: true, verbose: true, help: false, version: false)',
        );
      });

      test('converts help container to string', () {
        expect(
          ArgumentsContainer(
            paths: [],
            help: true,
          ).toString(),
          'ArgumentsContainer(paths: [], spaceIndent: null, tabIndent: null, verbose: false, help: true, version: false)',
        );
      });

      test('converts version container to string', () {
        expect(
          ArgumentsContainer(
            paths: [],
            version: true,
          ).toString(),
          'ArgumentsContainer(paths: [], spaceIndent: null, tabIndent: null, verbose: false, help: false, version: true)',
        );
      });
    });
  });
}
