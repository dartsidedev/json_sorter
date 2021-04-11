* Split test files for the bin
* Move most of the app logic from bin to lib/src
* Test MOAR:
  * args container str
  * build indent
  * json sorted encode func
  * pubspec gen files are empty (the ones I need)
  * probably more stuff...
* Handle common error scenarios
  * file does not exist: print, skip (if there are more files, sort them)
  * no permissions to write?
  * file is not valid JSON

