/// Class for holding CLI arguments with type information.
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
