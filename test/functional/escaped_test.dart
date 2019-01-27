import 'package:disp/disp.dart';
import 'package:test/test.dart';

void main() {
  group('Escaped', () {
    group('SExp', () {
      <String, Node>{
        '(id `())': SExp.empty(),
        '(id `(1))': SExp.wrap([Int(1)]),
        '(id `(1 2))': SExp.wrap([Int(1), Int(2)]),
        '(id `name)': Ident('name'),
        '(id `(sum 1 2))': SExp.wrap([Ident('sum'), Int(1), Int(2)]),
      }.forEach((source, expected) {
        test('"$source"', () {
          final tree = parseString(source).value;
          final actual = evaluate(standardContext, tree);
          expect(actual, expected);
        });
      });
    });
  });
}
