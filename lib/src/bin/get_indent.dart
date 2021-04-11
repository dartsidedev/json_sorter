/// Create indent string based on spaces and tabs arguments to CLI.
///
/// If the returned value is null, no indentation.
String? getIndent(int? spaces, bool? tab) {
  if (spaces == null && tab == null) return null;
  if (spaces != null && tab != null) {
    throw ArgumentError('Both tab and space indentation is specified');
  }
  if (spaces != null) return ' ' * spaces;
  if (tab == true) {
    return '\t';
  } else if (tab == false) {
    throw ArgumentError('Tab must not be set to false');
  }
}
