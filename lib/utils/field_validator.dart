String? validateField(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field required';
  }
  return null;
}
