import 'package:dumblisp/src/binding.dart';

// TODO: Accept AST nodes instead of Dart values
// TODO: Add helpers to do type assertions on values

abstract class Context {
  static ContextBuilder builder() => ContextBuilderImpl();

  /// Returns the binding with the given name, or `null` if no
  /// such binding exists in this [Context].
  Binding binding(String name);

  /// All of the names that are bound to symbols in this context.
  Iterable<String> get boundNames;
}

class ContextImpl implements Context {
  ContextImpl(this._bindings);

  final Map<String, Binding> _bindings;

  @override
  Binding binding(String name) => _bindings[name];

  @override
  Iterable<String> get boundNames => _bindings.keys;
}

abstract class ContextBuilder {
  /// Add one or more bindings to the context being built that
  /// will supersede any existing bindings, including any
  /// bindings added with [addContext].
  void addAllBindings(Iterable<Binding> bindings);

  /// Add a single binding to the context being built that will
  /// supersede any existing bindings, including any bindings
  /// added with [addContext].
  void addBinding(Binding binding);

  /// Layer an entire [Context] onto the one being built that
  /// will supersede any previous layers.
  void addContext(Context context);

  /// Build an immutable [Context] with the bindings that exist
  /// in the builder.
  Context build();
}

class ContextBuilderImpl implements ContextBuilder {
  Map<String, Binding> _bindings = {};

  List<Context> _contexts = [];

  @override
  void addAllBindings(Iterable<Binding> bindings) {
    for (final binding in bindings) {
      addBinding(binding);
    }
  }

  @override
  void addBinding(Binding binding) {
    _bindings[binding.name] = binding;
  }

  @override
  void addContext(Context context) {
    _contexts.add(context);
  }

  @override
  Context build() {
    final contextMap = <String, Binding>{};
    for (final context in _contexts) {
      for (final name in context.boundNames) {
        contextMap[name] = context.binding(name);
      }
    }
    for (final pair in _bindings.entries) {
      contextMap[pair.key] = pair.value;
    }
    return ContextImpl(contextMap);
  }
}
