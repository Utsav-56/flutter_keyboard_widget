// key_combos.dart

library;

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:keyboard_scaffold/consts.dart';

/// Callback type for key events
typedef KeyCallback = void Function();

class KeyCombo {
  final List<LogicalKeyboardKey> modifiers;
  final Map<LogicalKeyboardKey, KeyCallback> bindings;

  KeyCombo({this.modifiers = const [], required this.bindings}) {
    if (!areSupportedModifierKeys(modifiers)) {
      throw ArgumentError(
        "KeyCombo: Unsupported modifier key found in modifiers list: ${modifiers.map((k) => k.debugName).join(', ')}",
      );
    }

    // Ensure modifiers are unique
    final modSet = <LogicalKeyboardKey>{};
    for (final mod in modifiers) {
      modSet.add(mod);
    }

    modifiers.clear();
    modifiers.addAll(modSet);
  }

  /// Check if the combo is active based on currently pressed modifiers
  bool matches(Set<LogicalKeyboardKey> pressed) {
    for (final mod in modifiers) {
      // resolve alias for ctrl and alt keys to handle left/right variants
      if (mod == ctrlKey) {
        if (!(pressed.contains(ctrlLeftKey) || pressed.contains(ctrlRightKey))) {
          return false;
        }
      } else if (mod == altKey) {
        if (!(pressed.contains(altLeftKey) || pressed.contains(altRightKey))) {
          return false;
        }
      } else {
        if (!pressed.contains(mod)) return false;
      }
    }
    return true;
  }

  /// Handle the key event by invoking the appropriate callback
  /// [triggeredKey] is the key that was just pressed (non-modifier key)
  void handle(LogicalKeyboardKey triggeredKey) {
    final callback = bindings[triggeredKey];
    if (callback != null) {
      print("KeyCombo: Executing callback for key: ${triggeredKey.debugName}");
      callback.call();
    }
  }

  /// Check if this combo has a binding for the given key
  bool hasBindingFor(LogicalKeyboardKey key) {
    return bindings.containsKey(key);
  }
}
