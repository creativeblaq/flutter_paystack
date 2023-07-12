import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/widgets/common/extensions.dart';

class PinField extends StatefulWidget {
  final ValueChanged<String>? onSaved;
  final int pinLength;
  final Color? secondaryColor;

  final Color? textColor;

  PinField(
      {this.onSaved, this.pinLength = 4, this.secondaryColor, this.textColor});

  @override
  State createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  @override
  Widget build(BuildContext context) {
    final secondaryColor =
        widget.secondaryColor ?? Theme.of(context).colorScheme.secondary;
    final textColor =
        widget.textColor ?? Theme.of(context).colorScheme.onBackground;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: new TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //color: Colors.black87,
          fontSize: 25.0,
          letterSpacing: 15.0,
        ),
        autofocus: true,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          new LengthLimitingTextInputFormatter(widget.pinLength),
        ],
        obscureText: true,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
          hintText: 'ENTER PIN',
          hintStyle: const TextStyle(
            //color: Colors.grey,
            fontSize: 14.0,
            letterSpacing: 0,
          ),
          contentPadding: const EdgeInsets.all(10.0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[700]!, width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor, width: 1.0)),
        ),
        onChanged: (String value) {
          if (value.length == widget.pinLength) {
            widget.onSaved!(value);
          }
        },
      ),
    );
  }
}
