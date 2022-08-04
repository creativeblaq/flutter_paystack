import 'package:flutter/material.dart';
import 'package:flutter_paystack/src/common/paystack.dart';
import 'package:flutter_paystack/src/widgets/animated_widget.dart';
import 'package:flutter_paystack/src/widgets/buttons.dart';

class ErrorWidget extends StatefulWidget {
  final TickerProvider vSync;
  final AnimationController controller;
  final CheckoutMethod method;
  final String? text;
  final VoidCallback? payWithBank;
  final VoidCallback? tryAnotherCard;
  final VoidCallback? startOverWithCard;
  final bool isCardPayment;

  ErrorWidget({
    required this.text,
    required this.vSync,
    required this.method,
    required this.isCardPayment,
    this.payWithBank,
    this.tryAnotherCard,
    this.startOverWithCard,
  }) : controller = new AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: vSync,
        ) {
    controller.forward();
  }

  @override
  State<ErrorWidget> createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  final emptyContainer = new Container();

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Remove 'Retry buttons for bank payment because when you retry a transaction it ret
    var buttonMargin =
        widget.isCardPayment ? new SizedBox(height: 5.0) : emptyContainer;
    return new Container(
      child: new CustomAnimatedWidget(
        controller: widget.controller,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(
              Icons.warning,
              size: 50.0,
              color: const Color(0xFFf9a831),
            ),
            new SizedBox(height: 10.0),
            new Text(
              widget.text!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                //color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            new SizedBox(height: 25.0),
            widget.isCardPayment
                ? new WhiteButton(
                    onPressed: widget.tryAnotherCard, text: 'Try another card')
                : emptyContainer,
            buttonMargin,
            widget.method == CheckoutMethod.selectable ||
                    widget.method == CheckoutMethod.bank
                ? new WhiteButton(
                    onPressed: widget.payWithBank,
                    text: widget.method == CheckoutMethod.bank ||
                            !widget.isCardPayment
                        ? 'Retry'
                        : 'Try paying with your bank account',
                  )
                : emptyContainer,
            buttonMargin,
            widget.isCardPayment
                ? new WhiteButton(
                    onPressed: widget.startOverWithCard,
                    text: 'Start over with same card',
                    iconData: Icons.refresh,
                    bold: false,
                    flat: true,
                  )
                : emptyContainer
          ],
        ),
      ),
    );
  }
}
