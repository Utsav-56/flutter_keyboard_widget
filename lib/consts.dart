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
