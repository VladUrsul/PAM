// presentation/utils/icon_helper.dart
class IconHelper {
  static String getIconForCategory(String category) {
    switch (category) {
      case "Dentist":
        return "assets/icons/dentist.png";
      case "Cardiologist":
        return "assets/icons/cardiologist.png";
      default:
        return "assets/icons/default.png";
    }
  }
}
