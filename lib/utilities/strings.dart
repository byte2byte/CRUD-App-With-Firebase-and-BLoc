class StringConstant {
  static const String addrValidateMessage =
      "Your Address should have min of 10 characters";
  static const String nameValidateMessage = "Only alphabets are allowed";
  static const String numberValidateMessage =
      "Enter 10 Digits Mobile Number with Country Code";
  static const String emailField = "email";
  static const String dataField = "Data";
  static const String collectionName = "users";
  static const String emailValidateMessage = "Enter a valid email";
  static const String passwordValidateMessage =
      "Password must be at least 4 characters";
  static const String passwordHint = "Enter Password";
  static const String emailHint = "Enter Email ID";
  static const String submit = "Submit";
  static const String errorMessage = "Please fix all the errors";
  static const String dataListTitle = "Data List";
  static const String worldTab = "World";
  static const String myTab = "Data";
}

checkForNull(String check) {
  if (check == null) {
    return "";
  } else {
    return check;
  }
}

class GlobalData {
  static String URL =
      "https://static.vecteezy.com/system/resources/previews/000/420/553/original/avatar-icon-vector-illustration.jpg";
}
