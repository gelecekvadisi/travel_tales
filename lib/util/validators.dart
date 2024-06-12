import 'package:email_validator/email_validator.dart';

class Validators {
  static const String emptyValue = "Bu alan boş bırakılamaz";

  static String? userName(String? value) {
    if (value == null || value.isEmpty) {
      return emptyValue;
    } else if (value.length < 3) {
      return "Kullanıcı adı 3 karakterden az olamaz";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return emptyValue;
    } if (!EmailValidator.validate(value)) {
      return "Lütfen geçerli bir e-posta adresi giriniz";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return emptyValue;
    } if (value.length < 6) {
      return "Parolanız en az 6 haneli olmak zorundadır";
    }
    return null;
  }
}
