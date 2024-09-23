class FieldsValidator {
  static String? isNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field must not be empty';
    }
    return null;
  }

  static String? isValidEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isNotEmpty(value);
    }
    const emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? isValidPassword(String? value, {int minLength = 8}) {
    if (value == null || value.trim().isEmpty) {
      return isNotEmpty(value);
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    return null;
  }

  static String? isValidPhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isNotEmpty(value);
    }
    const phonePattern = r'^\+?[0-9]{7,15}$'; 
    final regex = RegExp(phonePattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? isValidURL(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isNotEmpty(value);
    }
    const urlPattern =
        r'^(https?:\/\/)?([\w\d\-]+\.)+[\w]{2,}(\/.+)?$'; 
    final regex = RegExp(urlPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid URL';
    }
    return null;
  }

  static String? isValidUsername(String? value, {int minLength = 3}) {
    if (value == null || value.trim().isEmpty) {
      return isNotEmpty(value);
    }
    if (value.length < minLength) {
      return 'Username must be at least $minLength characters long';
    }
    return null;
  }
}
