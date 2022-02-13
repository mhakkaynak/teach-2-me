import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';

class CustomTextField extends TextField {
  CustomTextField(
      {Key? key,
      required TextEditingController controller,
      TextAlign? textAlign,
      int? maxLines,
      TextInputType? keyboardType,
      TextStyle? textStyle,
      Widget? suffix,
      String? hintText,
      TextStyle? hintTextStyle,
      required BuildContext context})
      : super(
          textAlign: textAlign ?? TextAlign.start,
          key: key,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          cursorColor: Colors.white,
          cursorWidth: 2,
          style: textStyle ??
              TextStyle(color: context.currentTheme.colorScheme.background),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            filled: true,
            fillColor: context.currentTheme.primaryColor,
            suffixIcon: suffix,
            hintText: hintText,
            hintStyle: hintTextStyle ??
                TextStyle(
                  color: context.currentTheme.colorScheme.background,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PTSans',
                ),
          ),
        );
}
