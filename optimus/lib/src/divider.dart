import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// Divider is a visual representation of a separation between two areas.
class OptimusDivider extends StatelessWidget {
  const OptimusDivider({
    super.key,
    this.child,
    this.direction = Axis.horizontal,
    this.variant = OptimusDividerVariant.normal,
    this.crossAxisSpacing = spacing100,
  });

  /// The text to display in the middle of the divider. If null, the divider
  /// will be just a line.
  final Widget? child;

  /// The direction of the divider.
  final Axis direction;

  /// Controls the boldness of the color of the divider. Won't affect the
  /// divider's thickness.
  final OptimusDividerVariant variant;

  /// The spacing of the cross axis.
  final double crossAxisSpacing;

  double get _verticalPadding =>
      direction == Axis.horizontal ? crossAxisSpacing : spacing200;

  double get _horizontalPadding =>
      direction == Axis.horizontal ? spacing200 : crossAxisSpacing;

  Widget _buildDivider(Color dividerColor) => switch (direction) {
        Axis.horizontal => Divider(color: dividerColor, thickness: 1),
        Axis.vertical => VerticalDivider(color: dividerColor, thickness: 1),
      };

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final child = this.child;

    return Flex(
      direction: direction,
      children: [
        Expanded(child: _buildDivider(variant.getColor(theme))),
        if (child != null) ...[
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: _horizontalPadding,
              vertical: _verticalPadding,
            ),
            child: DefaultTextStyle.merge(
              style: preset100s.copyWith(color: theme.colors.neutral1000t64),
              child: child,
            ),
          ),
          Expanded(child: _buildDivider(variant.getColor(theme))),
        ]
      ],
    );
  }
}

enum OptimusDividerVariant { normal, bold }

extension on OptimusDividerVariant {
  Color getColor(OptimusThemeData theme) => switch (this) {
        OptimusDividerVariant.normal => theme.colors.neutral50,
        OptimusDividerVariant.bold => theme.colors.neutral200,
      };
}
