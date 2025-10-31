/// Keyboard constants for Flutter applications.
///
/// This file provides a comprehensive collection of predefined keyboard key constants
/// organized by category, making it easier to handle keyboard input in Flutter apps.
/// All constants are based on [LogicalKeyboardKey] from the Flutter services package.
///

library;

// consts.dart
import 'package:flutter/services.dart';

// Mega / Modifier Keys
const ctrlKey = LogicalKeyboardKey.control;
const ctrlLeftKey = LogicalKeyboardKey.controlLeft;
const ctrlRightKey = LogicalKeyboardKey.controlRight;

const altKey = LogicalKeyboardKey.alt;
const altLeftKey = LogicalKeyboardKey.altLeft;
const altRightKey = LogicalKeyboardKey.altRight;

const shiftKey = LogicalKeyboardKey.shift;
const shiftLeftKey = LogicalKeyboardKey.shiftLeft;
const shiftRightKey = LogicalKeyboardKey.shiftRight;

const metaKey = LogicalKeyboardKey.meta;

const supportedModifierKeys = [
  ctrlKey,
  ctrlLeftKey,
  ctrlRightKey,

  altKey,
  altLeftKey,
  altRightKey,

  shiftKey,
  shiftLeftKey,
  shiftRightKey,

  metaKey,
];

bool isSupportedModifierKey(LogicalKeyboardKey key) {
  return supportedModifierKeys.contains(key);
}

bool areSupportedModifierKeys(List<LogicalKeyboardKey> keys) {
  for (final key in keys) {
    if (!isSupportedModifierKey(key)) {
      return false;
    }
  }
  return true;
}

// Navigation Keys
const escKey = LogicalKeyboardKey.escape;
const tabKey = LogicalKeyboardKey.tab;
const enterKey = LogicalKeyboardKey.enter;
const backspaceKey = LogicalKeyboardKey.backspace;
const spaceKey = LogicalKeyboardKey.space;
const homeKey = LogicalKeyboardKey.home;
const endKey = LogicalKeyboardKey.end;
const pageUpKey = LogicalKeyboardKey.pageUp;
const pageDownKey = LogicalKeyboardKey.pageDown;
const insKey = LogicalKeyboardKey.insert;
const delKey = LogicalKeyboardKey.delete;
const upKey = LogicalKeyboardKey.arrowUp;
const downKey = LogicalKeyboardKey.arrowDown;
const leftKey = LogicalKeyboardKey.arrowLeft;
const rightKey = LogicalKeyboardKey.arrowRight;

// Function Keys
const f1 = LogicalKeyboardKey.f1;
const f2 = LogicalKeyboardKey.f2;
const f3 = LogicalKeyboardKey.f3;
const f4 = LogicalKeyboardKey.f4;
const f5 = LogicalKeyboardKey.f5;
const f6 = LogicalKeyboardKey.f6;
const f7 = LogicalKeyboardKey.f7;
const f8 = LogicalKeyboardKey.f8;
const f9 = LogicalKeyboardKey.f9;
const f10 = LogicalKeyboardKey.f10;
const f11 = LogicalKeyboardKey.f11;
const f12 = LogicalKeyboardKey.f12;

// Printable Keys
const keyA = LogicalKeyboardKey.keyA;
const keyB = LogicalKeyboardKey.keyB;
const keyC = LogicalKeyboardKey.keyC;
const keyD = LogicalKeyboardKey.keyD;
const keyE = LogicalKeyboardKey.keyE;
const keyF = LogicalKeyboardKey.keyF;
const keyG = LogicalKeyboardKey.keyG;
const keyH = LogicalKeyboardKey.keyH;
const keyI = LogicalKeyboardKey.keyI;
const keyJ = LogicalKeyboardKey.keyJ;
const keyK = LogicalKeyboardKey.keyK;
const keyL = LogicalKeyboardKey.keyL;
const keyM = LogicalKeyboardKey.keyM;
const keyN = LogicalKeyboardKey.keyN;
const keyO = LogicalKeyboardKey.keyO;
const keyP = LogicalKeyboardKey.keyP;
const keyQ = LogicalKeyboardKey.keyQ;
const keyR = LogicalKeyboardKey.keyR;
const keyS = LogicalKeyboardKey.keyS;
const keyT = LogicalKeyboardKey.keyT;
const keyU = LogicalKeyboardKey.keyU;
const keyV = LogicalKeyboardKey.keyV;
const keyW = LogicalKeyboardKey.keyW;
const keyX = LogicalKeyboardKey.keyX;
const keyY = LogicalKeyboardKey.keyY;
const keyZ = LogicalKeyboardKey.keyZ;

// Printable num keys
const key0 = LogicalKeyboardKey.digit0;
const key1 = LogicalKeyboardKey.digit1;
const key2 = LogicalKeyboardKey.digit2;
const key3 = LogicalKeyboardKey.digit3;
const key4 = LogicalKeyboardKey.digit4;
const key5 = LogicalKeyboardKey.digit5;
const key6 = LogicalKeyboardKey.digit6;
const key7 = LogicalKeyboardKey.digit7;
const key8 = LogicalKeyboardKey.digit8;
const key9 = LogicalKeyboardKey.digit9;

/// A utility function that dynamically generates [LogicalKeyboardKey] instances for alphanumeric characters:
///
/// Args:
/// [char] : the string of the character that needs to be mapped into logicalKeyboardKey
///
/// returns:
/// [LogicalKeyboardKey] instance of the given character
///
/// Throws:
/// [ArgumentError] if the given key is unsupported or invalid character
///
/// Usage:
/// ```dart
/// final key =  key('A');
/// // this will set to LogicalKeyboardKey.keyA
/// ```
LogicalKeyboardKey key(String char) {
  // Utility to get A–Z, 0–9 dynamically
  char = char.toLowerCase();
  final code = char.codeUnitAt(0);
  if (code >= 97 && code <= 122) {
    // a-z
    return LogicalKeyboardKey(LogicalKeyboardKey.keyA.keyId + (code - 97));
  }
  if (code >= 48 && code <= 57) {
    // 0-9
    return LogicalKeyboardKey(LogicalKeyboardKey.digit0.keyId + (code - 48));
  }
  throw ArgumentError('Unsupported key "$char"');
}

/// class to hold key names
///
/// keynames are readable string constants for keys
class KeyName {
  static final names = {
    ctrlKey: 'Control',
    ctrlLeftKey: 'Control L',
    ctrlRightKey: 'Control R',

    altKey: 'Alt',
    altLeftKey: 'Alt L',
    altRightKey: 'Alt R',

    shiftKey: 'Shift',
    shiftLeftKey: 'Shift L',
    shiftRightKey: 'Shift R',

    metaKey: 'Meta',

    escKey: 'Escape',
    tabKey: 'Tab',
    enterKey: 'Enter',
    backspaceKey: 'Backspace',
    spaceKey: 'Space',
    homeKey: 'Home',
    endKey: 'End',
    pageUpKey: 'Page Up',
    pageDownKey: 'Page Down',
    insKey: 'Insert',
    delKey: 'Delete',

    upKey: 'Arrow Up',
    downKey: 'Arrow Down',
    leftKey: 'Arrow Left',
    rightKey: 'Arrow Right',

    f1: 'F1',
    f2: 'F2',
    f3: 'F3',
    f4: 'F4',
    f5: 'F5',
    f6: 'F6',
    f7: 'F7',
    f8: 'F8',
    f9: 'F9',
    f10: 'F10',
    f11: 'F11',
    f12: 'F12',

    keyA: 'A',
    keyB: 'B',
    keyC: 'C',
    keyD: 'D',
    keyE: 'E',
    keyF: 'F',
    keyG: 'G',
    keyH: 'H',
    keyI: 'I',
    keyJ: 'J',
    keyK: 'K',
    keyL: 'L',
    keyM: 'M',
    keyN: 'N',
    keyO: 'O',
    keyP: 'P',
    keyQ: 'Q',
    keyR: 'R',
    keyS: 'S',
    keyT: 'T',
    keyU: 'U',
    keyV: 'V',
    keyW: 'W',
    keyX: 'X',
    keyY: 'Y',
    keyZ: 'Z',

    key0: '0',
    key1: '1',
    key2: '2',
    key3: '3',
    key4: '4',
    key5: '5',
    key6: '6',
    key7: '7',
    key8: '8',
    key9: '9',
  };

  static String forKey(LogicalKeyboardKey key) {
    return names[key] ?? key.debugName ?? 'Unknown Key';
  }

  static String forKeys(List<LogicalKeyboardKey> keys) {
    return keys.map((k) => normalisedKeyName(k)).join('+');
  }

  static bool isKeyEqual(LogicalKeyboardKey a, LogicalKeyboardKey b) {
    if (a == ctrlKey && (b == ctrlLeftKey || b == ctrlRightKey)) return true;
    if (a == altKey && (b == altLeftKey || b == altRightKey)) return true;
    if (a == shiftKey && (b == shiftLeftKey || b == shiftRightKey)) return true;

    if (b == ctrlKey && (a == ctrlLeftKey || a == ctrlRightKey)) return true;
    if (b == altKey && (a == altLeftKey || a == altRightKey)) return true;
    if (b == shiftKey && (a == shiftLeftKey || a == shiftRightKey)) return true;

    return a.keyId == b.keyId;
  }

  static areKeysEqual(List<LogicalKeyboardKey> a, List<LogicalKeyboardKey> b) {
    if (a.length != b.length) return false;
    for (final keyA in a) {
      bool found = false;
      for (final keyB in b) {
        if (isKeyEqual(keyA, keyB)) {
          found = true;
          break;
        }
      }
      if (!found) return false;
    }
    return true;
  }

  static String normalisedKeyName(LogicalKeyboardKey key) {
    // resolve alias for ctrl and alt keys to handle left/right variants

    if (key == ctrlKey) {
      return '${forKey(ctrlRightKey)}/${forKey(ctrlLeftKey)}';
    } else if (key == altKey) {
      return '${forKey(altRightKey)}/${forKey(altLeftKey)}';
    } else {
      return forKey(key);
    }
  }
}
