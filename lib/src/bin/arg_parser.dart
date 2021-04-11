import 'package:args/args.dart';

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
