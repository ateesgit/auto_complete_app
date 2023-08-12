import 'package:flutter/material.dart';

/// Flutter code sample for [Autocomplete].
// This example shows how to create an Autocomplete widget with a custom type. 
//Try searching with text from the name or email field.

@immutable
class User {
  const User({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  String toString() {
    return '$name, $email';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.name == name && other.email == email;
  }

  @override
  int get hashCode => Object.hash(email, name);
}

class AutocompleteBasicUserExample extends StatelessWidget {
  const AutocompleteBasicUserExample({super.key});

  static const List<User> _userOptions = <User>[
    User(name: 'Alice', email: 'alice@example.com'),
    User(name: 'Bob', email: 'bob@example.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
  ];

  static String _displayStringForOption(User option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<User>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<User>.empty();
        }
        return _userOptions.where((User option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (User selection) {
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}
