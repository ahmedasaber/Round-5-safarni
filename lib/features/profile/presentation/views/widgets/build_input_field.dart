// presentation/views/widgets/build_input_field.dart
import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class BuildInputField extends StatelessWidget {
  final String label;
  final String icon;
  final String? placeholder;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool obscureText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final int? maxLines;

  const BuildInputField({
    super.key,
    required this.label,
    required this.icon,
    this.placeholder,
    this.controller,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.obscureText = false,
    this.onTap,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.font14DarkBlackNormal,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          enabled: enabled,
          obscureText: obscureText,
          onTap: onTap,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                icon,
                width: 20,
                height: 20,
                color: Colors.grey[600],
              ),
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}