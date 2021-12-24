import 'package:flutter/material.dart';
import 'package:zimbo/utils/color_utils.dart';

const Size kDefaultSize = Size.square(10.0);
const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);
const ShapeBorder kDefaultShape = CircleBorder();

class DotsDecorator {
  final Color color;
  final Color activeColor;
  final Size size;
  final Size activeSize;
  final ShapeBorder shape;
  final ShapeBorder activeShape;
  final EdgeInsets spacing;

  const DotsDecorator({
    this.color = ColorUtils.appColorBlack_10,
    this.activeColor = ColorUtils.appColorAccent,
    this.size = kDefaultSize,
    this.activeSize = kDefaultSize,
    this.shape = kDefaultShape,
    this.activeShape = kDefaultShape,
    this.spacing = kDefaultSpacing,
  });
}
