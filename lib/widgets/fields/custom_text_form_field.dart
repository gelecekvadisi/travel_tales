import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../util/constants.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
  });

  String label;
  String? hint;
  TextInputType keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isPassword;
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isPassword = widget.keyboardType == TextInputType.visiblePassword;
    isObscure = isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Constants.defaultPadding / 2),
      child: Column(
        children: [
          _buildLabel(context),
          const SizedBox(height: Constants.defaultPadding / 3),
          _buildField(context),
        ],
      ),
    );
  }

  TextFormField _buildField(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: isObscure,
      obscuringCharacter: Constants.obscuringCharacter,
      decoration: InputDecoration(
        hintText: widget.hint,
        // hintStyle: Theme.of(context).textTheme.bodyMedium,
        contentPadding: const EdgeInsets.all(Constants.defaultPadding * 0.75),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: Constants.defaultBorderWidth),
          borderRadius: BorderRadius.circular(Constants.defaultRadius),
        ),
        suffixIcon: !isPassword
            ? null
            : IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Image.asset(
                  isObscure
                      ? "assets/icons/eye_off.png"
                      : "assets/icons/eye_on.png",
                  width: 24, //Theme.of(context).iconTheme.size,
                ),
              ),
      ),
    );
  }

  Align _buildLabel(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
