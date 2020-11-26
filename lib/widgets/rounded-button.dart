

import 'package:flutter/material.dart';

import '../palette.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final onPressed;
  const RoundedButton({ Key key, @required this.buttonText, @required this.onPressed}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16)
      ),
      child: FlatButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(buttonText,
              style: kBodyText,
            ),
          )
      ),
    );
  }
}


