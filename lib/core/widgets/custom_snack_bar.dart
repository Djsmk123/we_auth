import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSnackBar(
    {required bool isSuccess,
    required String msg,
    required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
      snackBarCustom(isSuccess: isSuccess, msg: msg, context: context));
}

SnackBar snackBarCustom(
    {required bool isSuccess,
    required String msg,
    required BuildContext context}) {
  return SnackBar(
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    padding: EdgeInsets.symmetric(horizontal: 20.r),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    behavior: SnackBarBehavior.floating,
    width: 300.w,
    duration: const Duration(seconds: 2),
    content: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: ListTile(
          leading: Icon(
            !isSuccess ? Icons.error : Icons.done,
            color: Colors.white,
            size: 30.r,
          ),
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0,
          horizontalTitleGap: 5,
          title: Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: Colors.white),
          ),
        ))
      ],
    ),
  );
}
