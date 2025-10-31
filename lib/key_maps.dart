// key_maps.dart

import 'package:flutter/services.dart';
import 'package:keyboard_scaffold/keyboard_scaffold.dart';

class KeyMaps {
  final List<KeyCombo> combos;
  final Set<LogicalKeyboardKey> _pressed = {};
  final Set<LogicalKeyboardKey> _modifiersPressed = {};
  final Map<String, KeyCombo> _comboMap = {};

  KeyMaps({required this.combos}) {
    print("KeyMaps: Initializing with ${combos.length} key combos");
    _deduplicateAndBuildComboMap();
    print("KeyMaps: Built combo map with ${_comboMap.length} unique modifier sets");

    for (int i = 0; i < combos.length; i++) {
      final combo = combos[i];
      print(
        "KeyMaps: Combo $i - Modifiers: [${KeyName.forKeys(combo.modifiers)}], "
        "Bindings: [${KeyName.forKeys(combo.bindings.keys.toList())}]",
      );

      print("\n\n");
    }
  }

  ///ensure that all the key combos have unique modifiers,
  ///
  /// e.g if 2 modifiers have same [ctrl, shift]
  /// in such case we will warn in console and combine them into a single combo internally,
  /// if during combination if 2 bindings collides, e.g both have keyA bindings then we will also combine them as, void callback() { callbackOf!st, callbackof2nd }
  /// we will respect both of them just internally cleanup duplicates,
  /// and after final merger only we store in map ,
  void _deduplicateAndBuildComboMap() {
    final Map<String, List<KeyCombo>> modifierGroups = {};

    // Group combos by their modifier keys
    for (final combo in combos) {
      final key = _keyFor(combo.modifiers);
      if (!modifierGroups.containsKey(key)) {
        modifierGroups[key] = [];
      }
      modifierGroups[key]!.add(combo);
    }

    // Process each group
    for (final entry in modifierGroups.entries) {
      final modifierKey = entry.key;
      final comboList = entry.value;

      if (comboList.length > 1) {
        print(
          "KeyMaps Warning: Found ${comboList.length} key combos with same modifiers [$modifierKey]. "
          "Merging them into a single combo.",
        );
      }

      // Merge all combos with the same modifiers
      final mergedBindings = <LogicalKeyboardKey, List<KeyCallback>>{};
      List<LogicalKeyboardKey>? modifiers;

      for (final combo in comboList) {
        modifiers ??= combo.modifiers;

        // Collect all bindings
        for (final binding in combo.bindings.entries) {
          if (!mergedBindings.containsKey(binding.key)) {
            mergedBindings[binding.key] = [];
          }
          mergedBindings[binding.key]!.add(binding.value);
        }
      }

      // Create final bindings with combined callbacks
      final finalBindings = <LogicalKeyboardKey, KeyCallback>{};
      for (final entry in mergedBindings.entries) {
        final key = entry.key;
        final callbacks = entry.value;

        if (callbacks.length > 1) {
          print(
            "KeyMaps Warning: Key ${key.debugName} has ${callbacks.length} callbacks for modifiers [$modifierKey]. "
            "Combining them into a single callback.",
          );

          // Create a combined callback that calls all callbacks in sequence
          finalBindings[key] = () {
            for (final callback in callbacks) {
              callback();
            }
          };
        } else {
          finalBindings[key] = callbacks.first;
        }
      }

      // Create and store the merged combo
      final mergedCombo = KeyCombo(modifiers: modifiers ?? [], bindings: finalBindings);
      _comboMap[modifierKey] = mergedCombo;
    }
  }

  /// Generates a key based on modifiers to put in hashmap for easy retrieval
  /// Normalizes ctrl/alt variants to their base keys
  String _keyFor(List<LogicalKeyboardKey> modifiers) {
    final normalized = <LogicalKeyboardKey>[];

    for (final mod in modifiers) {
      // Normalize left/right variants to base keys
      if (mod == ctrlLeftKey || mod == ctrlRightKey) {
        if (!normalized.contains(ctrlKey)) {
          normalized.add(ctrlKey);
        }
      } else if (mod == altLeftKey || mod == altRightKey) {
        if (!normalized.contains(altKey)) {
          normalized.add(altKey);
        }
      } else {
        normalized.add(mod);
      }
    }

    final sorted = normalized.map((k) => k.keyLabel ?? k.debugName ?? k.keyId.toString()).toList()
      ..sort();
    return sorted.join('+');
  }

  /// Normalize the currently pressed modifiers for lookup
  String _normalizedModifierKey() {
    final normalized = <LogicalKeyboardKey>[];

    for (final mod in _modifiersPressed) {
      // Normalize left/right variants to base keys
      if (mod == ctrlLeftKey || mod == ctrlRightKey) {
        if (!normalized.contains(ctrlKey)) {
          normalized.add(ctrlKey);
        }
      } else if (mod == altLeftKey || mod == altRightKey) {
        if (!normalized.contains(altKey)) {
          normalized.add(altKey);
        }
      } else {
        normalized.add(mod);
      }
    }

    return _keyFor(normalized);
  }

  bool isModifier(LogicalKeyboardKey key) {
    return supportedModifierKeys.contains(key); // supportedModifierKeys from consts.dart
  }

  @Deprecated('use handleKeyEvent instead')
  void handleRawEvent(RawKeyEvent event) {
    final isDown = event is RawKeyDownEvent;
    final key = event.logicalKey;

    if (isDown) {
      _pressed.add(key);
    } else {
      _pressed.remove(key);
    }

    for (final combo in _comboMap.values) {
      if (combo.matches(_pressed)) {
        print("KeyMaps: Combo matched for keys: ${_pressed.map((k) => k.debugName).join(', ')}");
        combo.handle(key); // Pass only the newly pressed key
      }
    }
  }

  bool isAlreadyPressed(LogicalKeyboardKey key) {
    return _pressed.contains(key) || _modifiersPressed.contains(key);
  }

  void handleKeyEvent(KeyEvent event) {
    final key = event.logicalKey;

    if (event is KeyDownEvent) {
      if (isModifier(key)) {
        // Always add modifiers, even if already pressed (for repeat prevention)
        if (!_modifiersPressed.contains(key)) {
          _modifiersPressed.add(key);
          print("KeyMaps: Modifier key ${key.debugName} pressed");
        }
      } else {
        // For non-modifier keys, allow re-triggering if modifiers are still held
        final wasAlreadyPressed = _pressed.contains(key);
        _pressed.add(key);

        // Get normalized key for current modifiers (could be empty string if no modifiers)
        final keyForModifiers = _normalizedModifierKey();
        final combo = _comboMap[keyForModifiers];

        if (combo != null) {
          // Check if the combo has a binding for the triggered key
          if (combo.hasBindingFor(key)) {
            if (wasAlreadyPressed) {
              print(
                "KeyMaps: Re-triggering combo for modifiers [$keyForModifiers], key: ${key.debugName}",
              );
            } else {
              print(
                "KeyMaps: Combo found for modifiers [$keyForModifiers], triggering key: ${key.debugName}",
              );
            }
            combo.handle(key);
          } else {
            print(
              "KeyMaps: Combo found for modifiers [$keyForModifiers], but no binding for key: ${key.debugName}",
            );
          }
        } else {
          print("KeyMaps: No combo found for modifiers [$keyForModifiers]");
        }
      }
    } else if (event is KeyUpEvent) {
      if (isModifier(key)) {
        _modifiersPressed.remove(key);
      } else {
        _pressed.remove(key);
      }
    }

    print("""
New state:
Modifiers pressed: ${_modifiersPressed.map((k) => k.debugName).join(', ')}
Keys pressed: ${_pressed.map((k) => k.debugName).join(', ')}
""");
  }
}
