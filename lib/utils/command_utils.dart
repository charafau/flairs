class CommandUtils {
  static RegExp resNameRegEx = RegExp('^[a-zA-Z]\$');

  static bool isResourceName(String input) {
    if (input != null && input.isNotEmpty && !resNameRegEx.hasMatch(input)) {
      return true;
    }
    return false;
  }
}
