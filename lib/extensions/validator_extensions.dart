import 'package:crypto/crypto.dart';
import 'dart:convert';

extension ValidatorExtensions on String {
  String? validatePassword() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (isEmpty || !regex.hasMatch(this)) {
      return 'At least 1 capital letter, 1 number and 1 special character.';
    } else if (length < 8) {
      return 'Use 8 or more characters for your password.';
    } else {
      return null;
    }
  }

  String hashPass() {
    return sha512.convert(utf8.encode(this)).toString();
  }

  String? validateCode() {
    if (isEmpty || length != 6) {
      return 'The code must be 6 digits.';
    }
    return null;
  }

  String? validateEmail() {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    if (isEmpty || !regex.hasMatch(this)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? validatePhone() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern);

    if (isEmpty || !regex.hasMatch(this)) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  String? validateFirstName() {
    String pattern = '[a-zA-Z]';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(this)) {
      return 'Enter a valid first name.';
    }
    return null;
  }

  String? validateLastName() {
    String pattern = r'^[a-zA-ZÀ-ÿ0-9\s-]+$';
    RegExp regex = RegExp(pattern);
    if (isEmpty || !regex.hasMatch(this)) {
      return 'Enter a valid last name.';
    }
    return null;
  }

  String? validateZipCode() {
    String pattern = r'^((0[1-9])|([1-8][0-9])|(9[0-8])|(2A)|(2B))[0-9]{3}$';
    RegExp regex = RegExp(pattern);
    if (isEmpty || !regex.hasMatch(this)) {
      return 'Enter a valid zip code.';
    }
    return null;
  }

  String? validateAddress() {
    String pattern = r'([0-9]*) ?([a-zA-Z,\. ]*)';
    RegExp regex = RegExp(pattern);
    if (isEmpty || !regex.hasMatch(this)) {
      return 'Enter a valid address.';
    }
    return null;
  }

  String? validateCity() {
    String pattern = r'([0-9]*) ?([a-zA-Z,\. ]*)';
    RegExp regex = RegExp(pattern);
    if (isEmpty || !regex.hasMatch(this)) {
      return 'Enter a valid city.';
    }
    return null;
  }

  String? validateBirthDate() {
    String pattern = r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/([12][0-9]{3})$';
    RegExp regex = RegExp(pattern);
    if (isEmpty || !regex.hasMatch(this)) {
      return 'Enter a valid birth date.';
    }
    return null;
  }
}
