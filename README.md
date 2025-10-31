# keyboard_scaffold

A Flutter package that provides an elegant solution for handling keyboard shortcuts in your Flutter applications. keyboard_scaffold makes it easy to define and manage keyboard combinations with a clean, intuitive API.

## Features

- **Easy Keyboard Shortcut Management**: Define keyboard shortcuts with simple, readable syntax
- **Comprehensive Key Support**: Includes constants for all common keys (letters, numbers, function keys, navigation keys, modifiers)
- **Modifier Key Handling**: Built-in support for Ctrl, Alt, Shift, and Meta keys with automatic left/right variant resolution
- **Drop-in Replacement**: `KeyboardScaffold` is a complete replacement for Flutter's `Scaffold` widget
- **Key Combination Mapping**: Register multiple key combinations with different callbacks
- **No Dependencies**: Built purely on Flutter's services package

## Getting started

Add keyboard_scaffold to your `pubspec.yaml`:

```yaml
dependencies:
    keyboard_scaffold: ^1.0.0
```

Import the package:

```dart
import 'package:keyboard_scaffold/keyboard_scaffold.dart';
```

## Usage

The core of keyboard_scaffold is the `KeyboardScaffold` widget, which wraps Flutter's standard `Scaffold` and adds keyboard shortcut handling capabilities. You define your keyboard shortcuts using `KeyCombo` and `KeyMaps` classes.

For now only the `ctrlKey`, `altKey`, `shiftKey`, and `metaKey` modifier keys are supported (You can only create key combinations with these keys).

The packages provides constants for common keys, such as:- Letters: `keyA`, `keyB`, ..., `keyZ`

- Numbers: `key0`, `key1`, ..., `key9`
- Function Keys: `f1`, `f2`, ..., `f12`

so that you can easily reference them when defining your key combinations.

### Basic Example

Here's a simple example that increments a counter when Ctrl+A is pressed:

```dart
import 'package:flutter/material.dart';
import 'package:keyboard_scaffold/keyboard_scaffold.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  late final keyCombo = KeyCombo(
    modifiers: [ctrlKey],
    bindings: {
      keyA: _incrementCounter,
    },
  );

  late final keymap = KeyMaps(combos: [keyCombo]);

  @override
  Widget build(BuildContext context) {
    return KeyboardScaffold(
      keyMaps: keymap,
      appBar: AppBar(title: const Text('Keyboard Shortcut Demo')),
      body: Center(
        child: Text('Counter: $_counter'),
      ),
    );
  }
}
```

### Advanced Example with Multiple Shortcuts

```dart
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _lastAction = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
      _lastAction = 'Incremented';
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _lastAction = 'Decremented';
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _lastAction = 'Reset';
    });
  }

  void _showWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Warning: Ctrl+W pressed')),
    );
  }

  late final keyCombo1 = KeyCombo(
    modifiers: [ctrlKey],
    bindings: {
      keyA: _incrementCounter,
      keyS: _decrementCounter,
      keyR: _resetCounter,
      keyW: _showWarning,
    },
  );

  late final keyCombo2 = KeyCombo(
    modifiers: [ctrlKey, shiftKey],
    bindings: {
      keyA: () {
        setState(() {
          _counter += 10;
          _lastAction = 'Fast increment';
        });
      },
    },
  );

  late final keymap = KeyMaps(combos: [keyCombo1, keyCombo2]);

  @override
  Widget build(BuildContext context) {
    return KeyboardScaffold(
      keyMaps: keymap,
      appBar: AppBar(title: const Text('Advanced Shortcuts')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $_counter', style: Theme.of(context).textTheme.headlineMedium),
            Text('Last Action: $_lastAction'),
            const SizedBox(height: 20),
            const Text('Shortcuts:'),
            const Text('Ctrl+A: Increment'),
            const Text('Ctrl+S: Decrement'),
            const Text('Ctrl+R: Reset'),
            const Text('Ctrl+Shift+A: Fast Increment (+10)'),
            const Text('Ctrl+W: Show Warning'),
          ],
        ),
      ),
    );
  }
}
```

### Function Key Example

```dart
late final functionKeyCombo = KeyCombo(
  modifiers: [],
  bindings: {
    f1: () => _showHelp(),
    f2: () => _toggleSettings(),
    f5: () => _refresh(),
    f11: () => _toggleFullscreen(),
  },
);
```

### Navigation Key Example

```dart
late final navigationCombo = KeyCombo(
  modifiers: [altKey],
  bindings: {
    upKey: () => _navigateUp(),
    downKey: () => _navigateDown(),
    leftKey: () => _navigatePrevious(),
    rightKey: () => _navigateNext(),
    homeKey: () => _goToHome(),
    endKey: () => _goToEnd(),
  },
);
```

## API Reference

### KeyboardScaffold

A widget that wraps Flutter's `Scaffold` and adds keyboard shortcut handling capabilities.

**Properties:**

- `keyMaps`: The `KeyMaps` instance containing your keyboard shortcuts
- All standard `Scaffold` properties (appBar, body, floatingActionButton, etc.)

**Example:**

```dart
KeyboardScaffold(
  keyMaps: myKeyMaps,
  appBar: AppBar(title: Text('My App')),
  body: MyBody(),
)
```

### KeyCombo

Defines a keyboard combination with modifiers and key bindings.

**Constructor:**

```dart
KeyCombo({
  List<LogicalKeyboardKey> modifiers = const [],
  required Map<LogicalKeyboardKey, KeyCallback> bindings,
})
```

**Parameters:**

- `modifiers`: List of modifier keys (ctrlKey, altKey, shiftKey, metaKey)
- `bindings`: Map of keys to callback functions

**Example:**

```dart
KeyCombo(
  modifiers: [ctrlKey, shiftKey],
  bindings: {
    keyS: () => _saveFile(),
    keyN: () => _createNew(),
  },
)
```

### KeyMaps

Manages multiple keyboard combinations and handles key events.

**Constructor:**

```dart
KeyMaps({required List<KeyCombo> combos})
```

**Example:**

```dart
final combo1 = KeyCombo(
  modifiers: [ctrlKey],
  bindings: {
    keyA: () => print('Ctrl+A pressed'),
  },
);

final combo2 = KeyCombo(
  modifiers: [ctrlKey, shiftKey],
  bindings: {
    keyS: () => print('Ctrl+Shift+S pressed'),
  },
);

final combo3 = KeyCombo(
  modifiers: [],
  bindings: {
    f1: () => print('F1 pressed'),
  },
);

final keyMaps = KeyMaps(
  combos: [combo1, combo2, combo3],
);
```

### Available Key Constants

The package provides convenient constants for all keys:

**Modifier Keys:**

- `ctrlKey`, `ctrlLeftKey`, `ctrlRightKey`
- `altKey`, `altLeftKey`, `altRightKey`
- `shiftKey`, `shiftLeftKey`, `shiftRightKey`
- `metaKey`

**Letter Keys:**

- `keyA` through `keyZ`

**Number Keys:**

- `key0` through `key9`

**Function Keys:**

- `f1` through `f12`

**Navigation Keys:**

- `escKey`, `tabKey`, `enterKey`, `backspaceKey`, `spaceKey`
- `homeKey`, `endKey`, `pageUpKey`, `pageDownKey`
- `insKey`, `delKey`
- `upKey`, `downKey`, `leftKey`, `rightKey`

### Dynamic Key Function

For dynamic key generation:

```dart
LogicalKeyboardKey key(String char)
```

**Example:**

```dart
final keyA = key('a');  // Returns LogicalKeyboardKey.keyA
final key5 = key('5');  // Returns LogicalKeyboardKey.digit5
```

### KeyName Utility

Get human-readable names for keys:

```dart
String keyName = KeyName.forKey(keyA);  // Returns "A"
String combo = KeyName.forKeys([ctrlKey, keyS]);  // Returns "Control+S"
```

## Complete Working Example

Here's a complete example demonstrating various features:

```dart
import 'package:flutter/material.dart';
import 'package:keyboard_scaffold/keyboard_scaffold.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard Scaffold Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _counter = 0;
  String _lastShortcut = 'None';

  void _updateCounter(int delta, String shortcut) {
    setState(() {
      _counter += delta;
      _lastShortcut = shortcut;
    });
  }

  late final basicCombo = KeyCombo(
    modifiers: [ctrlKey],
    bindings: {
      keyA: () => _updateCounter(1, 'Ctrl+A'),
      keyS: () => _updateCounter(-1, 'Ctrl+S'),
      keyR: () {
        setState(() {
          _counter = 0;
          _lastShortcut = 'Ctrl+R (Reset)';
        });
      },
    },
  );

  late final advancedCombo = KeyCombo(
    modifiers: [ctrlKey, shiftKey],
    bindings: {
      keyA: () => _updateCounter(10, 'Ctrl+Shift+A'),
      keyS: () => _updateCounter(-10, 'Ctrl+Shift+S'),
    },
  );

  late final functionCombo = KeyCombo(
    modifiers: [],
    bindings: {
      f1: () {
        _showDialog('Help', 'Press Ctrl+A to increment\nPress Ctrl+S to decrement');
      },
      f5: () {
        setState(() {
          _counter = 0;
          _lastShortcut = 'F5 (Refresh)';
        });
      },
    },
  );

  late final keyMaps = KeyMaps(combos: [basicCombo, advancedCombo, functionCombo]);

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardScaffold(
      keyMaps: keyMaps,
      appBar: AppBar(
        title: const Text('Keyboard Scaffold Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Counter: $_counter',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Last Shortcut: $_lastShortcut',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                'Available Shortcuts:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildShortcutInfo('Ctrl+A', 'Increment by 1'),
              _buildShortcutInfo('Ctrl+S', 'Decrement by 1'),
              _buildShortcutInfo('Ctrl+R', 'Reset counter'),
              _buildShortcutInfo('Ctrl+Shift+A', 'Increment by 10'),
              _buildShortcutInfo('Ctrl+Shift+S', 'Decrement by 10'),
              _buildShortcutInfo('F1', 'Show help'),
              _buildShortcutInfo('F5', 'Refresh (reset)'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShortcutInfo(String shortcut, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              shortcut,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
          const SizedBox(width: 10),
          Text(description),
        ],
      ),
    );
  }
}
```

## Tips and Best Practices

1. **Modifier Key Aliasing**: The package automatically handles left/right variants of modifier keys. Using `ctrlKey` will match both `ctrlLeftKey` and `ctrlRightKey`.

2. **Multiple Combos**: You can register multiple `KeyCombo` instances with the same modifiers but different keys, or different modifiers altogether.

3. **State Management**: Callbacks can access widget state through closures, making it easy to integrate with setState or other state management solutions.

4. **Focus Management**: `KeyboardScaffold` automatically manages focus to ensure keyboard events are captured properly.

5. **Debugging**: The package includes print statements for debugging. Look for "KeyMaps:" and "KeyCombo:" prefixes in your console output.

## Social Media

Connect in social media for more information and updates:

- <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 256 256"><!-- Icon from Skill Icons by tandpfun - https://github.com/tandpfun/skill-icons/blob/main/LICENSE --><g fill="none"><rect width="256" height="256" fill="url(#SVGWRUqebek)" rx="60"/><rect width="256" height="256" fill="url(#SVGfkNpldMH)" rx="60"/><path fill="#fff" d="M128.009 28c-27.158 0-30.567.119-41.233.604c-10.646.488-17.913 2.173-24.271 4.646c-6.578 2.554-12.157 5.971-17.715 11.531c-5.563 5.559-8.98 11.138-11.542 17.713c-2.48 6.36-4.167 13.63-4.646 24.271c-.477 10.667-.602 14.077-.602 41.236s.12 30.557.604 41.223c.49 10.646 2.175 17.913 4.646 24.271c2.556 6.578 5.973 12.157 11.533 17.715c5.557 5.563 11.136 8.988 17.709 11.542c6.363 2.473 13.631 4.158 24.275 4.646c10.667.485 14.073.604 41.23.604c27.161 0 30.559-.119 41.225-.604c10.646-.488 17.921-2.173 24.284-4.646c6.575-2.554 12.146-5.979 17.702-11.542c5.563-5.558 8.979-11.137 11.542-17.712c2.458-6.361 4.146-13.63 4.646-24.272c.479-10.666.604-14.066.604-41.225s-.125-30.567-.604-41.234c-.5-10.646-2.188-17.912-4.646-24.27c-2.563-6.578-5.979-12.157-11.542-17.716c-5.562-5.562-11.125-8.979-17.708-11.53c-6.375-2.474-13.646-4.16-24.292-4.647c-10.667-.485-14.063-.604-41.23-.604zm-8.971 18.021c2.663-.004 5.634 0 8.971 0c26.701 0 29.865.096 40.409.575c9.75.446 15.042 2.075 18.567 3.444c4.667 1.812 7.994 3.979 11.492 7.48c3.5 3.5 5.666 6.833 7.483 11.5c1.369 3.52 3 8.812 3.444 18.562c.479 10.542.583 13.708.583 40.396s-.104 29.855-.583 40.396c-.446 9.75-2.075 15.042-3.444 18.563c-1.812 4.667-3.983 7.99-7.483 11.488c-3.5 3.5-6.823 5.666-11.492 7.479c-3.521 1.375-8.817 3-18.567 3.446c-10.542.479-13.708.583-40.409.583c-26.702 0-29.867-.104-40.408-.583c-9.75-.45-15.042-2.079-18.57-3.448c-4.666-1.813-8-3.979-11.5-7.479s-5.666-6.825-7.483-11.494c-1.369-3.521-3-8.813-3.444-18.563c-.479-10.542-.575-13.708-.575-40.413s.096-29.854.575-40.396c.446-9.75 2.075-15.042 3.444-18.567c1.813-4.667 3.983-8 7.484-11.5s6.833-5.667 11.5-7.483c3.525-1.375 8.819-3 18.569-3.448c9.225-.417 12.8-.542 31.437-.563zm62.351 16.604c-6.625 0-12 5.37-12 11.996c0 6.625 5.375 12 12 12s12-5.375 12-12s-5.375-12-12-12zm-53.38 14.021c-28.36 0-51.354 22.994-51.354 51.355s22.994 51.344 51.354 51.344c28.361 0 51.347-22.983 51.347-51.344c0-28.36-22.988-51.355-51.349-51.355zm0 18.021c18.409 0 33.334 14.923 33.334 33.334c0 18.409-14.925 33.334-33.334 33.334s-33.333-14.925-33.333-33.334c0-18.411 14.923-33.334 33.333-33.334"/><defs><radialGradient id="SVGWRUqebek" cx="0" cy="0" r="1" gradientTransform="matrix(0 -253.715 235.975 0 68 275.717)" gradientUnits="userSpaceOnUse"><stop stop-color="#FD5"/><stop offset=".1" stop-color="#FD5"/><stop offset=".5" stop-color="#FF543E"/><stop offset="1" stop-color="#C837AB"/></radialGradient><radialGradient id="SVGfkNpldMH" cx="0" cy="0" r="1" gradientTransform="matrix(22.25952 111.2061 -458.39518 91.75449 -42.881 18.441)" gradientUnits="userSpaceOnUse"><stop stop-color="#3771C8"/><stop offset=".128" stop-color="#3771C8"/><stop offset="1" stop-color="#60F" stop-opacity="0"/></radialGradient></defs></g></svg> **Instagram**: [@i_am_utsav\_\_](https://www.instagram.com/i_am_utsav__/)
- <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 256 256"><!-- Icon from SVG Logos by Gil Barbara - https://raw.githubusercontent.com/gilbarbara/logos/master/LICENSE.txt --><path fill="#1877F2" d="M256 128C256 57.308 198.692 0 128 0S0 57.308 0 128c0 63.888 46.808 116.843 108 126.445V165H75.5v-37H108V99.8c0-32.08 19.11-49.8 48.348-49.8C170.352 50 185 52.5 185 52.5V84h-16.14C152.959 84 148 93.867 148 103.99V128h35.5l-5.675 37H148v89.445c61.192-9.602 108-62.556 108-126.445"/><path fill="#FFF" d="m177.825 165l5.675-37H148v-24.01C148 93.866 152.959 84 168.86 84H185V52.5S170.352 50 156.347 50C127.11 50 108 67.72 108 99.8V128H75.5v37H108v89.445A129 129 0 0 0 128 256a129 129 0 0 0 20-1.555V165z"/></svg> **Facebook**: [utsav.pokhrel.9674](https://www.facebook.com/utsav.pokhrel.9674)

- <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 256 290"><!-- Icon from SVG Logos by Gil Barbara - https://raw.githubusercontent.com/gilbarbara/logos/master/LICENSE.txt --><path fill="#FF004F" d="M189.72 104.421c18.678 13.345 41.56 21.197 66.273 21.197v-47.53a67 67 0 0 1-13.918-1.456v37.413c-24.711 0-47.59-7.851-66.272-21.195v96.996c0 48.523-39.356 87.855-87.9 87.855c-18.113 0-34.949-5.473-48.934-14.86c15.962 16.313 38.222 26.432 62.848 26.432c48.548 0 87.905-39.332 87.905-87.857v-96.995zm17.17-47.952c-9.546-10.423-15.814-23.893-17.17-38.785v-6.113h-13.189c3.32 18.927 14.644 35.097 30.358 44.898M69.673 225.607a40 40 0 0 1-8.203-24.33c0-22.192 18.001-40.186 40.21-40.186a40.3 40.3 0 0 1 12.197 1.883v-48.593c-4.61-.631-9.262-.9-13.912-.801v37.822a40.3 40.3 0 0 0-12.203-1.882c-22.208 0-40.208 17.992-40.208 40.187c0 15.694 8.997 29.281 22.119 35.9"/><path d="M175.803 92.849c18.683 13.344 41.56 21.195 66.272 21.195V76.631c-13.794-2.937-26.005-10.141-35.186-20.162c-15.715-9.802-27.038-25.972-30.358-44.898h-34.643v189.843c-.079 22.132-18.049 40.052-40.21 40.052c-13.058 0-24.66-6.221-32.007-15.86c-13.12-6.618-22.118-20.206-22.118-35.898c0-22.193 18-40.187 40.208-40.187c4.255 0 8.356.662 12.203 1.882v-37.822c-47.692.985-86.047 39.933-86.047 87.834c0 23.912 9.551 45.589 25.053 61.428c13.985 9.385 30.82 14.86 48.934 14.86c48.545 0 87.9-39.335 87.9-87.857z"/><path fill="#00F2EA" d="M242.075 76.63V66.516a66.3 66.3 0 0 1-35.186-10.047a66.47 66.47 0 0 0 35.186 20.163M176.53 11.57a68 68 0 0 1-.728-5.457V0h-47.834v189.845c-.076 22.13-18.046 40.05-40.208 40.05a40.06 40.06 0 0 1-18.09-4.287c7.347 9.637 18.949 15.857 32.007 15.857c22.16 0 40.132-17.918 40.21-40.05V11.571zM99.966 113.58v-10.769a89 89 0 0 0-12.061-.818C39.355 101.993 0 141.327 0 189.845c0 30.419 15.467 57.227 38.971 72.996c-15.502-15.838-25.053-37.516-25.053-61.427c0-47.9 38.354-86.848 86.048-87.833"/></svg> **TikTok**: [@i_am_utsav\_\_](https://www.tiktok.com/@i_am_utsav__)

If you have any questions or need further assistance, feel free to reach out through any of these channels.

## Additional Information

### Contributing

Contributions are welcome! Please feel free to submit issues or pull requests on our GitHub repository.

### Support

For bugs or feature requests, please file an issue on the GitHub repository.

### License

This package is licensed under the MIT License. See the LICENSE file for details.
