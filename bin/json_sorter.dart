import 'dart:io';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:json_sorter/json_sorter.dart';
import 'package:json_sorter/src/pubspec.dart';

Future<void> main(List<String> arguments) async {
  final args = parseArguments(arguments);

  if (args.help) return printHelp();

  if (args.version) return printVersion();

  void printMaybe(String message) {
    if (args.verbose) stdout.writeln(message);
  }

  printMaybe('Parsed arguments: $args');

  if (args.paths.isEmpty) {
    stderr.writeln('No input file specified');
    exitCode = 1;
    return;
  }

  final indent = buildIndent(args.spaceIndent, args.tabIndent);
  printMaybe('Indent with "$indent"');
  final encoder = indent == null
      ? JsonSortedEncoder()
      : JsonSortedEncoder.withIndent(indent);
  final end = indent == null ? '' : '\n';
  final futures = args.paths.map((path) async {
    final file = File(path);
    printMaybe('Read file $path');
    final fileContent = await file.readAsString();
    printMaybe('Decode JSON from file $path');
    final fileAsJson = jsonDecode(fileContent);
    printMaybe('Sort JSON content from file $path');
    final sortedContent = encoder.convert(fileAsJson);
    printMaybe('Write sorted JSON to $path');
    await file.writeAsString(sortedContent + end);
    printMaybe('File completed $path');
  });

  await Future.wait(futures);
  printMaybe('Success');
}

class ArgumentsContainer {
  ArgumentsContainer({
    required this.paths,
    this.spaceIndent,
    this.tabIndent,
    this.verbose = false,
    this.help = false,
    this.version = false,
  });

  final List<String> paths;
  final int? spaceIndent;
  final bool? tabIndent;
  final bool verbose;
  final bool help;
  final bool version;

  @override
  String toString() {
    final sb = StringBuffer('ArgumentsContainer(')
      ..write('paths: $paths, ')
      ..write('spaceIndent: $spaceIndent, ')
      ..write('tabIndent: $tabIndent, ')
      ..write('verbose: $verbose, ')
      ..write('help: $help, ')
      ..write('version: $version')
      ..write(')');
    return '$sb';
  }
}

final parser = ArgParser()
  ..addOption(
    'space-indent',
    help: 'Spaces used for indentation.',
    allowed: ['0', '1', '2', '3', '4', '5', '6', '7', '8'],
  )
  ..addFlag(
    'tab-indent',
    help: 'Use tab for indentation.',
    defaultsTo: null,
    negatable: false,
  )
  ..addFlag(
    'verbose',
    abbr: 'v',
    help: 'Noisy logging, verbose output.',
    defaultsTo: false,
    negatable: false,
  )
  ..addFlag(
    'help',
    abbr: 'h',
    help: 'Print this usage information.',
    defaultsTo: false,
    negatable: false,
  )
  ..addFlag(
    'version',
    help: 'Report the version of the json_sorter tool.',
    defaultsTo: false,
    negatable: false,
  );

ArgumentsContainer parseArguments(List<String> arguments) {
  final r = parser.parse(arguments);
  return ArgumentsContainer(
    paths: r.rest,
    spaceIndent: r['space-indent'] != null
        ? int.tryParse(r['space-indent'] as String)
        : null,
    tabIndent: r['tab-indent'] as bool?,
    verbose: r['verbose'] as bool,
    help: r['help'] as bool,
    version: r['version'] as bool,
  );
}

void printHelp() {
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
  stdout.write('$s');
}

void printVersion() {
  stdout.writeln(version);
}

String? buildIndent(int? spaces, bool? tab) {
  if (spaces == null && tab == null) return null;
  if (spaces != null && tab != null) {
    throw Exception('Both tab and space indentation is specified');
  }
  if (spaces != null) return ' ' * spaces;
  if (tab != null) return '\t';
  throw AssertionError('Unexpected state');
}
