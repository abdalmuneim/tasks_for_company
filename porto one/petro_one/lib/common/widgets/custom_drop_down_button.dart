import 'package:flutter/material.dart';
import 'package:petro_one/common/resources/app_color.dart';
import 'package:petro_one/common/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  const CustomDropDownButton({
    Key? key,
    this.items,
    this.onChanged,
    this.width,
    this.height,
    this.newValue,
    this.hintText,
    this.validator,
    this.labelText,
    this.contentPadding,
    this.textAlign,
    this.labelAlign,
    this.fillColor,
    this.onTap,
    this.labelColor,
    this.inputBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.iconColor,
    this.borderColor,
    this.dropdownColor,
    this.itemColor,
    this.borderRadius,
    this.icon,
    this.radius,
    this.hintStyle,
  }) : super(key: key);
  final List<T>? items;
  final void Function(T?)? onChanged;
  final double? width, height;

  final T? newValue;
  final String? hintText, labelText;
  final TextStyle? hintStyle;
  final String? Function(T?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign, labelAlign;
  final void Function()? onTap;
  final Color? labelColor,
      fillColor,
      iconColor,
      borderColor,
      dropdownColor,
      itemColor;
  final InputBorder? inputBorder, enabledBorder, disabledBorder;
  final Widget? icon;
  final BorderRadius? borderRadius;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      // dropdownColor: Theme.of(context).cardTheme.color,
      validator: validator,
      icon: icon ??
          Icon(
            Icons.arrow_drop_down,
            color: iconColor,
          ),

      value: newValue,
      dropdownColor: dropdownColor ?? Theme.of(context).cardTheme.color,
      items: items
          ?.map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: CustomText(
                text: e.toString(),
                fontSize: 9.sp,
                color: itemColor ?? AppColors.mainTints,
                fontWeight: FontWeight.w800,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      isDense: true,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
      decoration: InputDecoration(
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 10),
        hintText: hintText,
        hintStyle: hintStyle,
        fillColor: fillColor,
        filled: true,
        enabledBorder: enabledBorder ??
            Theme.of(context)
                .dropdownMenuTheme
                .inputDecorationTheme
                ?.enabledBorder,
        disabledBorder: disabledBorder ??
            Theme.of(context).inputDecorationTheme.disabledBorder,
        border: inputBorder ??
            Theme.of(context).dropdownMenuTheme.inputDecorationTheme?.border,
      ),
    );
  }
}
