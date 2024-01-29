import 'package:flutter/material.dart';
import 'package:petro_one/common/utils/extension.dart';
import 'package:sizer/sizer.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final double? size;
  final EdgeInsetsGeometry? padding;
  final List<Widget> steps;
  final List<Widget>? stepsDetails;
  final Axis? direction;
  final Color? notActiveColor, activeColor;
  final bool? enableLine;
  final bool? shrinkWrap;

  const CustomStepper({
    super.key,
    required this.currentStep,
    this.padding,
    this.size,
    required this.steps,
    this.stepsDetails,
    this.direction,
    this.enableLine,
    this.notActiveColor,
    this.activeColor,
    this.shrinkWrap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap ?? true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: direction ?? Axis.horizontal,
      itemCount: steps.length,
      itemBuilder: (context, index) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: size,
                  height: size,
                  alignment: Alignment.center,
                  padding: padding ??
                      EdgeInsets.symmetric(horizontal: 2.8.w, vertical: 2.8.w),
                  decoration: BoxDecoration(
                      color:
                          currentStep >= index ? activeColor : notActiveColor,
                      shape: BoxShape.circle),
                  child: Center(child: steps[index])),
              if (enableLine ?? true) ...[
                if (steps.length - 1 != index)
                  SizedBox(
                    width: steps.length + 20.w,
                    child: Divider(
                      thickness: 6,
                      color: currentStep - 1 >= index
                          ? activeColor
                          : notActiveColor,
                    ),
                  ),
              ] else ...[
                (steps.length + 15.w).sw,
              ]
            ],
          ),
          if (stepsDetails != null) ...[
            stepsDetails![index],
          ]
        ],
      ),
    );
  }
}
