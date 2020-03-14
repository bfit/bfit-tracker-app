import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';

class NextOnboardingButton extends StatelessWidget {
  final dynamic onboardingScreenWidget;
  final bool replaceNavigation;

  const NextOnboardingButton(
      {Key key, @required this.onboardingScreenWidget, this.replaceNavigation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (this.replaceNavigation == null || this.replaceNavigation == false) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => this.onboardingScreenWidget),
          );
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => this.onboardingScreenWidget));
        }
      },
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              CustomColor.MAYA_BLUE,
              Color(0xFF9BD8FF),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 150.0, minHeight: 52.0),
          alignment: Alignment.center,
          child: const AutoSizeText(
            'Next',
            minFontSize: 20,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
