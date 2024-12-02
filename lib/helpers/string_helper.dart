class StringHelper {
  static final StringHelper _singleton = StringHelper._internal();
  factory StringHelper() {return _singleton;}
  StringHelper._internal();


  static const String logIn = "LogIn";
  static const String enterEmail = "Enter Email";
  static const String enterPassword = "Enter Password";
  static const String location = "Location";
  static const String enterPlace = "Enter Place";
  static const String changeProfile = "Change Profile";
  static const String email = "Email";
  static const String name = "Name";
  static const String somethingWentWrong = "Something went wrong";
  static const String save = "Save";
  static const String weather = "Weather";
}