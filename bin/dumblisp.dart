import 'package:petitparser/petitparser.dart';

void main(List<String> args) {
  final lDblQuote = char('"').trim().map((_) => Quote.left);
  final rDblQuote = char('"').trim().map((_) => Quote.right);

  final lParen = char('(').trim().map((_) => Paren.left);
  final rParen = char(')').trim().map((_) => Paren.right);

  final ident = letter().plus().trim().flatten();
  final number = digit().plus().trim().flatten().map(int.parse);
  final string = lDblQuote & word().star().flatten() & rDblQuote;

  final list = undefined();
  final sExp = undefined();

  list.set((sExp | ident | number | string).plus());
  sExp.set(lParen & list & rParen);

  final start = sExp.end();

  final input = args[0];
  final tree = start.parse(input);

  print(tree);
}

enum Paren {
  left,
  right,
}

enum Quote {
  left,
  right,
}
