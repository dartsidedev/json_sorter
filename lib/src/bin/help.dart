import 'arg_parser.dart';
import 'pubspec_info.dart';

String get help {
  final s = StringBuffer()
    ..writeln('PACKAGE')
    ..writeln('  $name')
    ..writeln()
    ..writeln('DESCRIPTION')
    ..writeln('  $description')
    ..writeln()
    ..writeln('USAGE')
    ..writeln('  json_sorter [arguments] <paths>')
    ..writeln()
    ..writeln('EXAMPLES')
    ..writeln('  > Sort example-file.json with 4 spaces used for indentation')
    ..writeln('  json_sorter --space-indent 4 example-file.json')
    ..writeln()
    ..writeln('  > Sort example-file.json with tabs used for indentation')
    ..writeln('  json_sorter --tab-indent example-file.json')
    ..writeln()
    ..writeln('  > Sort example-file.json without any indentation')
    ..writeln('  json_sorter example-file.json')
    ..writeln()
    ..writeln('OPTIONS')
    ..writeln(parser.usage)
    ..writeln()
    ..writeln('RESOURCES')
    ..writeln('  Source code: $homepage')
    ..writeln('  Issue tracker: $issueTracker')
    ..writeln('  Package info: https://pub.dev/packages/json_sorter');
  return '$s';
}
