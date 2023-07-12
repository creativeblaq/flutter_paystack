import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/widgets/common/extensions.dart';

class BaseTextField extends StatelessWidget {
  final Widget? suffix;
  final String? labelText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? initialValue;
  final bool isNumberField;
  Color? secondaryColor;
  Color? textColor;

  BaseTextField({
    Key? key,
    this.suffix,
    this.labelText,
    this.hintText,
    this.inputFormatters,
    this.onSaved,
    this.validator,
    this.controller,
    this.initialValue,
    this.secondaryColor,
    this.textColor,
    this.isNumberField = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //secondaryColor = secondaryColor ;
    textColor = textColor ?? Theme.of(context).colorScheme.onBackground;
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      validator: validator,
      maxLines: 1,
      initialValue: initialValue,
      keyboardType: isNumberField ? TextInputType.number : TextInputType.name,
      style: TextStyle(color: textColor),
      decoration: new InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        labelStyle: TextStyle(
            color: secondaryColor ?? Theme.of(context).colorScheme.secondary,
            fontSize: 14.0),
        suffixIcon: suffix == null
            ? null
            : new Padding(
                padding: const EdgeInsetsDirectional.only(end: 12.0),
                child: suffix,
              ),
        errorStyle: const TextStyle(fontSize: 12.0),
        errorMaxLines: 3,
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[700]!, width: 0.5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:
                    secondaryColor ?? Theme.of(context).colorScheme.secondary,
                width: 1.0)),
        hintText: hintText,
        hintStyle: TextStyle(color: textColor, fontSize: 14.0),
      ),
    );
  }
}
