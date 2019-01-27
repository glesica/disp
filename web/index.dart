import 'dart:html';

import 'package:disp/disp.dart';

void main() {
  final textSource = querySelector('#source') as TextAreaElement;
  final textOutput = querySelector('#output') as DivElement;

  (querySelector('#button-run') as ButtonElement)
    ..onClick.listen((event) async {
      final source = textSource.text;
      final tree = parseString(source);
      final output = evaluate(standardContext, tree.value);
      textOutput.text = output.toString();
    });
}
