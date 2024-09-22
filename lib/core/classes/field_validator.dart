class FieldValidator {
  static String? isNotEmpty(
    String? value,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'This field must not be empty';
    }
    return null;
  }
}
