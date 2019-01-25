import 'package:disp/src/ast/ident.dart';

class Var extends Ident {
  Var(String name) : super(name);

  static Var from(String value) => Var(value);

  @override
  String toString() => 'Var $name';
}