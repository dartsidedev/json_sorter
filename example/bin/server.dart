import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:json_sorter/json_sorter.dart';

const inputMap = {
  'xxx': {
    'r': 'r',
    'rr': 'rr',
    'q': 'q',
  },
  'abba': {
    'z': {
      'n': 1,
      's': 'f',
      'l': [],
      'm': {},
      'b': true,
    },
    'a': 1,
    'zz': 'zz',
    'bl': [true, true, false, false, null],
  },
  'baab': null,
  'aaa': [1, 1, 1],
};

void main(List<String> args) async {
  final handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(_echoRequest);

  await io.serve(handler, 'localhost', 3000);
  print('Serving at http://localhost:3000');
  print('Make a request to see sorted JSON response');
}

shelf.Response _echoRequest(shelf.Request request) {
  return shelf.Response.ok(
    jsonSortedEncode(inputMap),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}
