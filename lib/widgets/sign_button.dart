import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';

class SignButton extends StatelessWidget {
  const SignButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.labelColor,
    required this.color,
    required this.borderColor,
  });
  final void Function() onTap;
  final String label;
  final Color labelColor;
  final Color color;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 63,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: borderColor, width: 2.5)),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium!.copyWith(
                  fontSize: 19,
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
