class AssetsHelper {
  static String icBin = icon("bin.png");
  static String icEditing = icon("editing.png");
  static String icLogin = icon("login.png");
  static String icLogin1 = icon("login_text.png");
  static String icLogin2 = icon("login_icon.png");

  static String imgProfile = img("girl.png");
  static String imgAsus = img("asus.jpg");
  static String imgHeadset = img("headset.jpeg");
  static String imgHP = img("hp.jpg");
  static String imgJam = img("jam.jpeg");
  static String imgKeyboard = img("keyboard.jpg");

  static String icon(String name) {
    return "assets/icons/$name";
  }

  static String img(String name) {
    return "assets/images/$name";
  }
}
