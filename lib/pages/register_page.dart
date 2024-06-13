import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_tales/providers/all_providers.dart';
import 'package:travel_tales/util/constants.dart';
import 'package:travel_tales/util/validators.dart';
import 'package:travel_tales/widgets/loading_widget.dart';

import '../util/routes.dart';
import '../util/style.dart';
import '../widgets/fields/custom_text_form_field.dart';
import '../widgets/logo_widget.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});

  // static const String route = "register_page";

  String userName = "", email = "", password = "";
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    AsyncValue<User?> userAsync = ref.watch(userProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: userAsync.isLoading
          ? const LoadingWidget()
          : _buildBody(context, ref, theme),
    );
  }

  SafeArea _buildBody(BuildContext context, WidgetRef ref, ThemeData theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        child: Form(
          key: _formKey,
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
                validator: Validators.userName,
                onSaved: (value) {
                  userName = value!;
                },
              ),
              const Expanded(flex: 3, child: SizedBox()),
              CustomTextFormField(
                label: "E-Posta",
                hint: "E-Posta",
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
                onSaved: (value) {
                  email = value!;
                },
              ),
              const Expanded(flex: 3, child: SizedBox()),
              CustomTextFormField(
                label: "Parola",
                hint: Constants.obscuringCharacter * 6,
                keyboardType: TextInputType.visiblePassword,
                validator: Validators.password,
                onSaved: (value) {
                  password = value!;
                },
              ),
              const Expanded(flex: 4, child: SizedBox()),
              ElevatedButton(
                onPressed: () => _registerUser(ref: ref, context: context),
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

  _registerUser({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.read(userProvider.notifier).state = AsyncValue.loading();

        await Future.delayed(Duration(seconds: 5));

        await ref
            .read(authProvider)
            .registerUser(
              userName: userName,
              email: email,
              password: password,
            )
            .then(
          (value) {
            User user = value;
            String userId = user.uid;
            debugPrint("Kullanıcı Kaydedildi: $userId");

            ref.read(userProvider.notifier).state = AsyncValue.data(user);

            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.homePage,
              (route) => false,
            );
          },
        ).catchError(
          (e) {
            ref.read(userProvider.notifier).state = AsyncValue.error(
              e,
              StackTrace.current,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Bir hata meydana geldi!"),
              ),
            );
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
