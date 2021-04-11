# `json_sorter`

> Command-line tool to sort JSON files in-place by map key and reusable sorted JSON encoder. 
[![Continuous Integration](https://github.com/dartsidedev/json_sorter/workflows/Continuous%20Integration/badge.svg?branch=master)](https://github.com/dartsidedev/json_sorter/actions) [![codecov](https://codecov.io/gh/dartsidedev/json_sorter/branch/master/graph/badge.svg)](https://codecov.io/gh/dartsidedev/json_sorter) [![json_sorter](https://img.shields.io/pub/v/json_sorter?label=json_sorter&logo=dart)](https://pub.dev/packages/json_sorter 'See json_sorter package info on pub.dev') [![Published by dartside.dev](https://img.shields.io/static/v1?label=Published%20by&message=dartside.dev&logo=dart&logoWidth=30&color=40C4FF&labelColor=1d599b&labelWidth=100)](https://pub.dev/publishers/dartside.dev/packages) [![GitHub Stars Count](https://img.shields.io/github/stars/dartsidedev/json_sorter?logo=github)](https://github.com/dartsidedev/json_sorter 'Star me on GitHub!')

## Important links

* [Read the source code and **star the repo** on GitHub](https://github.com/dartsidedev/json_sorter)
* [Open an issue on GitHub](https://github.com/dartsidedev/json_sorter/issues)
* [See package on `pub.dev`](https://pub.dev/packages/json_sorter)
* [Read the docs on `pub.dev`](https://pub.dev/documentation/json_sorter/latest/)
* [Flutter Docs on "JSON and serialization"](https://flutter.dev/docs/development/data-and-backend/json)
* [`dart:convert` library docs](https://api.dart.dev/stable/2.12.2/dart-convert/dart-convert-library.html)
* [Dart Docs `pub run`](https://dart.dev/tools/pub/cmd/pub-run)

## Motivation

*Just imagine a team where every second pull request comment is about someone forgetting to sort the JSON file correctly...*
*...and just imagine this team not automating this task in five minutes rather they spend the same amount of time in every pull request nagging each other to sort the damn JSON file.*

I hope this does not sound familiar to you, but in case it does, read further!

## Introduction

With this package you can sort JSON files by key in-place using the
command-line tool provided by the package.

Ideal if your team is working with JSON files and you want to keep the JSON
files organized and you want to do that automatically.

The package also exposes [`JsonSortedEncoder`](https://pub.dev/documentation/json_sorter/latest/json_sorter/JsonSortedEncoder-class.html)
which is *very* similar to the `JsonEncoder`, except it first creates a copy
of the passed in object and then recursively sorts every map by key.

You can use the `JsonSortedEncoder` if you would like to make sure that in your
app, all JSON output (be it files or HTTP responses) is sorted.
It also supports custom indentation.

If you don't need custom indentation, just call the [`jsonSortedEncode`](https://pub.dev/documentation/json_sorter/latest/json_sorter/jsonSortedEncode.html)
function with the object you want to encode as JSON, and voila, all your keys are sorted.

## Usage

* `json_sorter` on the command-line: Install either globally or as a dev dependency
* `JsonSortedEncoder`, `jsonSortedEncode`: Install as a normal dependency

### `json_sorter` command-line tool

Keep in mind that how you invoke the `json_sorter` depends on how you installed it and whether you are using it from a Flutter or Dart project.

#### As dev dependency

You can run Dart scripts from your dependencies using the `pub run` command.

1. Add `json_sorter` to your `dev_dependencies`: `pub run add -d json_sorter`.
2. Run the script `pub run json_sorter --space-indent 2 filename.json`

#### Global installation

If you install `json_sorter` globally, you can execute it simply by typing `json_sorter example.json`.

```
pub global activate json_sorter
json_sorter --help
json_sorter --version
json_sorter --tab-indent example.json
```

### `JsonSortedEncoder`

If you want to create sorted JSONs in your apps, for example in your server's
responses, when you print a JSON response in your logs, or when you work with
Dart scripts that manipulate JSON files, you can use the `JsonSortedEncoder`.

It works similarly to the [`JsonEncoder` from `dart:convert`](https://api.dart.dev/stable/2.12.2/dart-convert/JsonEncoder-class.html).

If you don't need indentation, use simply the `JsonSortedEncoder` constructor.
If you need indentation, you can use the `JsonSortedEncoder.withIndent(indent)` constructor.

```dart
// After you added json_sorter to your dependencies
// $ dart pub add json_sorter
import 'package:json_sorter/json_sorter';

// Create encoder
const encoder = JsonSortedEncoder.withIndent('  ');

// Use it on any JSON serializable object, for example lists and maps
const example = {'b': true, 'a': false};

// Use the convert method
const asJson = encoder.convert(example);

// Enjoy
print(asJson);
```

### `jsonSortedEncode`

This handy function works exactly like the [`jsonEncode` from `dart:convert`](https://api.dart.dev/stable/2.9.3/dart-convert/jsonEncode.html),
the only difference is that it sorts the map keys recursively in the object before encoding.

```dart
import 'package:json_sorter/json_sorter.dart';

const inputMap = {
  'xxx': {
    'r': 'r',
    'rr': 'rr',
    'q': 'q',
  },
  'aaa': [1, 1, 1],
};

void main() {
    print(jsonSortedEncode(inputMap));
}
```

## `example`

Don't forget the project's [`example`](https://github.com/dartsidedev/json_sorter/tree/master/example) folder for more, executable examples.

