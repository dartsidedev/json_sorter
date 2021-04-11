import 'dart:io';
import 'dart:convert';

import 'package:json_sorter/json_sorter.dart';
import 'package:json_sorter/src/bin/arguments_container.dart';
import 'package:json_sorter/src/bin/get_indent.dart';
import 'package:json_sorter/src/bin/help.dart';
import 'package:json_sorter/src/bin/parse_arguments.dart';
import 'package:json_sorter/src/bin/pubspec_info.dart';

Future<void> main(List<String> arguments) async {
  void printError(String message) {
    stderr.writeln(message);
    exitCode = 2;
  }

  ArgumentsContainer args;

  try {
    args = parseArguments(arguments);
  } on FormatException catch (fe) {
    printError('Could not parse arguments. $fe');
    printError(
        'For help, execute one of the following (depending on your installation method):');
    printError('\$ json_sorter -h');
    printError('\$ pub run json_sorter -h');
    printError('\$ flutter pub run json_sorter -h');
    return;
  }

  if (args.help) return stdout.write('$help');

  if (args.version) return stdout.write('$version');

  void printVerbose(String message) {
    if (args.verbose) stdout.writeln(message);
  }

  printVerbose('Parsed arguments: $args');

  if (args.paths.isEmpty) {
    stderr.writeln('No input file specified');
    exitCode = 2;
    return;
  }

  final indent = getIndent(args.spaceIndent, args.tabIndent);

  if (indent == null) {
    printVerbose('No indentation set');
  } else {
    printVerbose('Indent with "$indent"');
  }

  final encoder = indent == null
      ? JsonSortedEncoder()
      : JsonSortedEncoder.withIndent(indent);

  final end = indent == null ? '' : '\n';

  if (end == '\n') {
    printVerbose('Newline will be added to the end of the file(s)');
  }

  final futures = args.paths.map((path) async {
    try {
      final file = File(path);
      printVerbose('Read file $path');
      final fileContent = await file.readAsString();
      printVerbose('Decode JSON from file $path');
      final fileAsJson = jsonDecode(fileContent);
      printVerbose('Sort JSON content from file $path');
      final sortedContent = encoder.convert(fileAsJson);
      printVerbose('Write sorted JSON to $path');
      await file.writeAsString(sortedContent + end);
      printVerbose('File completed $path');
    } on FileSystemException catch (fse) {
      printError(
          'FileSystemException for $path. ${fse.message}. ${fse.osError?.message}.');
    } on FormatException catch (fe) {
      printError('FormatException for $path. ${fe.message}.');
    }
  });

  await Future.wait(futures);

  printVerbose('Success. ${args.paths.length} file(s)');
}
