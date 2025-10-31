// key_maps.dart
import 'package:flutter/services.dart';
import 'package:keyboard_scaffold/keyboard_scaffold.dart';

class KeyMaps {
  final List<KeyCombo> combos;
  final _pressed = <LogicalKeyboardKey>{};
  final _modifiersPressed = <LogicalKeyboardKey>{};
  final _comboMap = <String, KeyCombo>{};

  KeyMaps({required this.combos}) {
    _buildComboMap();

    for (final combo in combos) {
      print("KeyMaps: Registered Combo - Modifiers: ${combo.identifier}");
    }
  }

  //  Build combo map with deduplication
  void _buildComboMap() {
    final groups = <String, List<KeyCombo>>{};
    for (final combo in combos) {
      final key = combo.identifier;
      (groups[key] ??= []).add(combo);
    }

    for (final entry in groups.entries) {
      final mergedBindings = <LogicalKeyboardKey, List<KeyCallback>>{};
      List<LogicalKeyboardKey>? modifiers;

      for (final combo in entry.value) {
        modifiers ??= combo.modifiers;
        combo.bindings.forEach((k, cb) => (mergedBindings[k] ??= []).add(cb));
      }

      final finalBindings = {
        for (final e in mergedBindings.entries)
          e.key: e.value.length == 1 ? e.value.first : () => e.value.forEach((cb) => cb()),
      };

      _comboMap[entry.key] = KeyCombo(modifiers: modifiers ?? [], bindings: finalBindings);
    }
  }

  //  Normalization helpers
  static final _normMap = {
    ctrlLeftKey: ctrlKey,
    ctrlRightKey: ctrlKey,
    altLeftKey: altKey,
    altRightKey: altKey,
  };

  String _keyFor(List<LogicalKeyboardKey> mods) =>
      KeyName.forKeys(mods.map((m) => _normMap[m] ?? m).toSet().toList());

  String _normalizedModifierKey() =>
      _keyFor(_modifiersPressed.map((m) => _normMap[m] ?? m).toSet().toList());

  bool _isModifier(LogicalKeyboardKey k) => supportedModifierKeys.contains(k);
  bool isAlreadyPressed(LogicalKeyboardKey k) =>
      _pressed.contains(k) || _modifiersPressed.contains(k);

  //  Main event handler
  void handleKeyEvent(KeyEvent e) {
    final key = e.logicalKey;

    if (e is KeyDownEvent) {
      if (_isModifier(key)) {
        _modifiersPressed.add(key);
      } else {
        final wasPressed = !_pressed.add(key);
        final combo = _comboMap[_normalizedModifierKey()];
        final cb = combo?.bindings[key];
        if (cb != null) cb();
      }
    } else if (e is KeyUpEvent) {
      (_isModifier(key) ? _modifiersPressed : _pressed).remove(key);
    }
  }
}
