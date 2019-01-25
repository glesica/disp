import 'package:dumblisp/dumblisp.dart';
import 'package:test/test.dart';

void main() {
  group('math', () {
    group('sum', () {
      <String, Node>{
        '(sum 0 1)': Int(1),
        '(sum 1 1)': Int(2),
        '(sum 0 1.0)': Float(1.0),
        '(sum 1.0 1)': Float(2.0),
        '(sum (sum 1 2) 3)': Int(6),
        '(sum 3 (sum 1 2))': Int(6),
        '(diff 1 0)': Int(1),
        '(diff 1 1)': Int(0),
        '((id sum) 1 2)': Int(3),
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
