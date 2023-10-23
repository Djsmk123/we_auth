import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../utils/color_config.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final int? maxLines;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  const CustomTextField(
      {super.key,
      required this.controller,
      this.keyboardType = TextInputType.text,
      required this.labelText,
      required this.hintText,
      this.maxLines,
      this.obscureText = false,
      this.suffixIcon,
      this.onChanged,
      this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.labelText,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp),
            ),
            if (widget.keyboardType == TextInputType.visiblePassword &&
                !widget.obscureText)
              Lottie.asset(
                'assets/eye.json',
                height: 50.h,
              ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
          validator: (value) {
            String? valid;
            if (widget.validator != null) {
              valid = widget.validator!(value);
            }
            if (valid == null && value!.isNotEmpty) {
              setState(() {
                isValid = true;
              });
            } else {
              setState(() {
                isValid = false;
              });
            }
            return valid;
          },
          obscureText: widget.obscureText,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.grey.shade200,
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: isValid ? 20 : 10),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                if (widget.suffixIcon != null) widget.suffixIcon!,
                if (isValid)
                  const Icon(Icons.check_circle, color: Colors.green),
              ]),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                    color: ColorConfig.primaryColor, width: 1)),
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
