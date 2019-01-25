import 'package:disp/src/ast/ident.dart';

class Func extends Ident {
  Func(String name) : super(name);

  static Func from(String value) => Func(value);

  @override
  String toString() => 'Func $name';
}