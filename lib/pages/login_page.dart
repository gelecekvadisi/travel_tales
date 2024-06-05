import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_tales/util/constants.dart';
import 'package:travel_tales/util/style.dart';
import 'package:travel_tales/widgets/fields/custom_text_form_field.dart';
import 'package:travel_tales/widgets/logo_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Constants.defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LogoWidget(),
                const Expanded(
                  flex: 6,
                  child: SizedBox(
                      // height: Constants.defaultPadding * 1.5,
                      ),
                ),
                Text(
                  "Hoş Geldiniz!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(
                    // height: Constants.defaultPadding / 4,
                  ),
                ),
                const Text(
                  "Kayıtlı hesabınıza ait E-Posta ve Parola bilginizi girerek oturum açabilirsiniz.",
                  textAlign: TextAlign.center,
                ),
                const Expanded(
                  flex: 6,
                  child: SizedBox(
                      // height: Constants.defaultPadding * 1.5,
                      ),
                ),
                CustomTextFormField(
                  label: "E-Posta",
                  hint: "E-Posta",
                  keyboardType: TextInputType.emailAddress,
                ),
                const Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: Constants.defaultPadding,
                  ),
                ),
                CustomTextFormField(
                  label: "Parola",
                  hint: Constants.obscuringCharacter * 6,
                  keyboardType: TextInputType.visiblePassword,
                ),
                _buildForgotPassword(context),
                const Expanded(
                  flex: 4,
                  child: SizedBox(
                      // height: Constants.defaultPadding,
                      ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Giriş Yap"),
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox(
                      // height: Constants.defaultPadding / 2,
                      ),
                ),
                Text(
                  "veya",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: theme.hintColor),
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox(
                      // height: Constants.defaultPadding / 2,
                      ),
                ),
                ElevatedButton.icon(
                  style: _socialButtonStyle(theme),
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/icons/google.png",
                    height: 24,
                    width: 24,
                  ),
                  label: const Text("Google ile Oturum Aç"),
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox(
                    // height: Constants.defaultPadding / 2,
                  ),
                ),
                ElevatedButton.icon(
                  style: _socialButtonStyle(theme),
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/icons/twitter.png",
                    height: 24,
                    width: 24,
                  ),
                  label: const Text("Twitter ile Oturum Aç"),
                ),
                const Expanded(
                  flex: 8,
                  child: SizedBox(
                      // height: Constants.defaultPadding * 2,
                      ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Bir hesabın yok mu? "),
                      TextSpan(
                        text: "Şimdi kaydol!",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Style.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _socialButtonStyle(ThemeData theme) {
    return ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Style.textColor,
        shape: theme.elevatedButtonTheme.style?.shape?.resolve({})?.copyWith(
            side: const BorderSide(
          color: Color(0xFFEBEBEB),
          width: 2,
        )));
  }

  Align _buildForgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () {
          _forgotPassword();
        },
        child: Text(
          "Parolamı Unuttum",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }

  _forgotPassword() {
    //  TODO: Parola Sıfırlama işlemi yazılacak
  }
}
