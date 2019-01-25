import 'package:disp/disp.dart';
import 'package:test/test.dart';

void main() {
  group('conditionals', () {
    group('if', () {
      <String, Node>{
        '(if true 1 0)': Int(1),
        '(if false 1 0)': Int(0),
        '((if true sum diff) 5 4)': Int(9),
        '((if false sum diff) 5 4)': Int(1),
      }.forEach((source, expected) {
        test('"$source"', () {
          final tree = parseString(source).value;
          final actual = evaluate(standardContext, tree);
          expect(actual, TypeMatcher<Num>());
          expect(actual, expected);
        });
      });
    });
  });
}
