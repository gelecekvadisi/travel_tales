import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_tales/util/constants.dart';
import 'package:travel_tales/widgets/fields/custom_text_form_field.dart';
import 'package:travel_tales/widgets/logo_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Constants.defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LogoWidget(),
                const SizedBox(height: Constants.defaultPadding * 1.5),
                Text(
                  "Hoş Geldiniz!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: Constants.defaultPadding / 4),
                const Text(
                  "Kayıtlı hesabınıza ait E-Posta ve Parola bilginizi girerek oturum açabilirsiniz.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Constants.defaultPadding,),
                CustomTextFormField(
                  label: "E-Posta",
                  hint: "E-Posta",
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextFormField(
                  label: "Parola",
                  hint: Constants.obscuringCharacter * 6,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
