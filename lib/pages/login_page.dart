import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_tales/pages/register_page.dart';
import 'package:travel_tales/providers/all_providers.dart';
import 'package:travel_tales/util/constants.dart';
import 'package:travel_tales/util/style.dart';
import 'package:travel_tales/util/validators.dart';
import 'package:travel_tales/widgets/fields/custom_text_form_field.dart';
import 'package:travel_tales/widgets/loading_widget.dart';
import 'package:travel_tales/widgets/logo_widget.dart';

import '../util/routes.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  String? email, password;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      FlutterNativeSplash.remove();
    });

    ThemeData theme = Theme.of(context);

    AsyncValue userAsync = ref.watch(userProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: userAsync.isLoading
          ? const LoadingWidget()
          : _buildBody(context, ref, theme),
    );
  }

  SafeArea _buildBody(BuildContext context, WidgetRef ref, ThemeData theme) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Constants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  "Kayıtlı hesabınıza ait E-Posta ve Parola bilginizi girerek oturum açabilirsiniz.",
                  textAlign: TextAlign.center,
                ),
                const Expanded(flex: 6, child: SizedBox()),
                CustomTextFormField(
                  label: "E-Posta",
                  hint: "E-Posta",
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  onSaved: (value) {
                    email = value;
                  },
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
                  validator: Validators.password,
                  onSaved: (value) {
                    password = value;
                  },
                ),
                _buildForgotPassword(context),
                const Expanded(flex: 4, child: SizedBox()),
                ElevatedButton(
                  onPressed: () {
                    _login(ref, context);
                  },
                  child: const Text("Giriş Yap"),
                ),
                const Expanded(flex: 2, child: SizedBox()),
                Text(
                  "veya",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: theme.hintColor),
                ),
                const Expanded(flex: 2, child: SizedBox()),
                ElevatedButton.icon(
                  style: Style.socialButtonStyle(theme),
                  onPressed: () {
                    _googleSignIn(context, ref);
                  },
                  icon: Image.asset(
                    "assets/icons/google.png",
                    height: 24,
                    width: 24,
                  ),
                  label: const Text("Google ile Oturum Aç"),
                ),
                /* const Expanded(flex: 2, child: SizedBox()),
                ElevatedButton.icon(
                  style: Style.socialButtonStyle(theme),
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/icons/twitter.png",
                    height: 24,
                    width: 24,
                  ),
                  label: const Text("Twitter ile Oturum Aç"),
                ), */
                const Expanded(flex: 8, child: SizedBox()),
                GestureDetector(
                  onTap: () {
                    _navigateToRegisterPage(context);
                  },
                  child: Text.rich(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  _navigateToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, Routes.registerPage);
  }

  _forgotPassword() {
    //  TODO: Parola Sıfırlama işlemi yazılacak
  }

  void _login(WidgetRef ref, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        ref.read(userProvider.notifier).state = const AsyncValue.loading();
        User? user = await ref.read(authProvider).login(
              email: email!,
              password: password!,
            );
        ref.read(userProvider.notifier).state = AsyncValue.data(user);
        _navigateToHome(context);
      } catch (e) {
        ref.read(userProvider.notifier).state = const AsyncValue.data(null);
        debugPrint(e.toString());
      }
    }
  }

  _googleSignIn(BuildContext context, WidgetRef ref) async {
    try {
      User? user = await ref.read(authProvider).googleSignIn();
      if (user != null) {
        _navigateToHome(context);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.homePage,
      (route) => false,
    );
  }
}
