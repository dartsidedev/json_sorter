import 'arg_parser.dart';
import 'arguments_container.dart';

/// Parse CLI arguments into typed [ArgumentsContainer].
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
