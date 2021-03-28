import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class OnboardingExerciseImage extends StatelessWidget {
  const OnboardingExerciseImage({
    Key key,
    @required this.transformInfo,
    @required this.mainImageAssetPath,
  }) : super(key: key);

  final TransformInfo transformInfo;
  final String mainImageAssetPath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      this.mainImageAssetPath,
      semanticsLabel: 'Exercise image',
    );
  }
}
