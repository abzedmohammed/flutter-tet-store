String capitalizeFirstLetter(String word) {
  return word[0].toUpperCase() + word.substring(1).toLowerCase();
}

extension EmailValidator on String {
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }
}
