import 'package:flutter/material.dart';

Future<void> showbottomSheetDialog(
    {required Widget widget, required AnimationController animation, required BuildContext context}) {
  return showModalBottomSheet<Widget>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
      transitionAnimationController: animation,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: widget,
        ));
      });
}
