import 'package:disp/disp.dart';
import 'package:test/test.dart';

void main() {
  group('lambda', () {
    group('expression', () {
      <String, Lambda>{
        '(lambda `() `())': Lambda(const [], SExp.empty()),
        '(lambda `(a) `(a))': Lambda([Ident('a')], SExp.wrap([Ident('a')])),
        '(lambda `(a b) `(a b))': Lambda(
            [Ident('a'), Ident('b')], SExp.wrap([Ident('a'), Ident('b')])),
      }.forEach((source, expected) {
        test('"$source"', () {
          final tree = parseString(source).value;
          final actual = evaluate(standardContext, tree);
          expect(actual, TypeMatcher<Lambda>());
          expect(actual, expected);
        });
      });
    });
  });
}
