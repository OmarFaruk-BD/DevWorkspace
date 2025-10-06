class AppValidator {
  String? validate(String? value, [String text = 'This field.']) {
    if (value == null || value.trim().isEmpty) {
      return '$text is required.';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name.';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long.';
    }
    // if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    //   return 'Name can only contain letters and spaces.';
    // }
    return null;
  }

  String? validatePhoneNo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number.';
    }
    if (value.length < 8 || value.length > 14) {
      return 'Please enter valid phone number.';
    }
    int? number = int.tryParse(value);
    if (number == null) {
      return 'Please enter valid phone number.';
    }
    return null;
  }

  String? validateOTP(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your OTP.';
    }
    if (value.length != 4) {
      return 'Please enter valid OTP.';
    }
    int? number = int.tryParse(value);
    if (number == null) {
      return 'Please enter valid OTP.';
    }
    return null;
  }

  String? validateNoOfPeople(int? value) {
    if (value == null) {
      return 'Please enter number of people.';
    }
    if (value < 1 || value > 100) {
      return 'Please enter valid number of people between 1 to 100.';
    }
    return null;
  }

  String? validateBabySitters(int? value) {
    if (value == null) {
      return 'Please enter number of baby sitters.';
    }
    if (value < 1 || value > 20) {
      return 'Please enter valid number of baby sitters between 1 to 100.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty.';
    }

    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');

    if (!regex.hasMatch(value)) {
      return 'Password must contain:\n'
          '- At least one uppercase letter\n'
          '- At least one lowercase letter\n'
          '- At least one digit\n'
          '- Be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter confirm password';
    }
    if (value != password?.trim()) {
      return 'Password and confirm password do not match';
    }
    return null;
  }
}
