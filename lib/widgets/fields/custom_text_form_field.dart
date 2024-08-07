import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../util/constants.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.validator,
    this.controller,
  });

  String label;
  String? hint;
  TextInputType keyboardType;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  TextEditingController? controller;

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
    return Column(
      children: [
        _buildLabel(context),
        const SizedBox(height: Constants.defaultPadding / 3),
        _buildField(context),
      ],
    );
  }

  TextFormField _buildField(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: isObscure,
      obscuringCharacter: Constants.obscuringCharacter,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        hintText: widget.hint,
        // hintStyle: Theme.of(context).textTheme.bodyMedium,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Constants.defaultPadding,
          vertical: Constants.defaultPadding / 2,
        ),
        constraints: BoxConstraints(minHeight: 0),
        isCollapsed: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: Constants.defaultBorderWidth),
          borderRadius: BorderRadius.circular(Constants.defaultRadius/2),
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
