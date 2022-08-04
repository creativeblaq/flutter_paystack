import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/common/my_strings.dart';
import 'package:flutter_paystack/src/widgets/input/base_field.dart';

class NameField extends BaseTextField {
  final Color? secondaryColor;
  final Color? textColor;
  NameField({
    Key? key,
    required FormFieldSetter<String> onSaved,
    this.secondaryColor,
    this.textColor,
  }) : super(
          labelText: 'Card holder',
          validator: _validate,
          onSaved: onSaved,
          secondaryColor: secondaryColor,
          textColor: textColor,
          hintText: 'John Doe',
          isNumberField: false,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            //FilteringTextInputFormatter.allow(RegExp(r'^[0-9]')),
            //FilteringTextInputFormatter.allow(RegExp(r"^'?-?")),
          ],
        );

  static String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) return Strings.invalidName;
    if (!RegExp(
            r"^([a-zA-Z]{2,}\s?[a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)+$")
        .hasMatch(value)) return Strings.invalidName;
    return null;
  }
}

const String namePattern = r'[a-z A-z]';
