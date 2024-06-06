import 'package:flutter/material.dart';
import 'package:travel_tales/util/constants.dart';

import '../util/routes.dart';
import '../util/style.dart';
import '../widgets/fields/custom_text_form_field.dart';
import '../widgets/logo_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  // static const String route = "register_page";

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const LogoWidget(),
              const Expanded(flex: 6, child: SizedBox()),
              Text(
                "Hoş Geldiniz!",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              const Text(
                "Kullanıcı adı, e-posta ve parola bilgilerinizi girerek Travel Tales'a hemen kaydolun.",
                textAlign: TextAlign.center,
              ),
              const Expanded(flex: 6, child: SizedBox()),
              CustomTextFormField(
                label: "Kullanıcı Adı",
                hint: "Kullanıcı Adı",
                keyboardType: TextInputType.name,
              ),
              const Expanded(flex: 3, child: SizedBox()),
              CustomTextFormField(
                label: "E-Posta",
                hint: "E-Posta",
                keyboardType: TextInputType.emailAddress,
              ),
              const Expanded(flex: 3, child: SizedBox()),
              CustomTextFormField(
                label: "Parola",
                hint: Constants.obscuringCharacter * 6,
                keyboardType: TextInputType.visiblePassword,
              ),
              const Expanded(flex: 4, child: SizedBox()),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Kayıt Ol"),
              ),
              const Expanded(flex: 2, child: SizedBox()),
              Text(
                "Veya oturum aç:",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: theme.hintColor),
              ),
              const Expanded(flex: 2, child: SizedBox()),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/icons/twitter.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/icons/google.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
              const Expanded(flex: 4, child: SizedBox()),
              GestureDetector(
                onTap: () {
                  _navigateToLogin(context);
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Bir hesabın var mı? "),
                      TextSpan(
                        text: "Şimdi giriş yap!",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Style.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.loginPage,
      (route) => false,
    );
  }
}
