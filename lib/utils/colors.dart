import 'dart:ui';

//primary color
const brandColorPrimary = "#FCD34D";
const colorPrimaryDark = "#0F172A";
const colorPrimaryLight = "#FFFBEB";
const colorPrimaryNormal = "#FCD34D";
const colorPrimaryWhite = "#FFFFFF";
//secondary color
const colorSecondaryNormal = "#0891B2";
//light color
const colorLightNormal = "#334155";

extension ColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll("#", "");
    hexColor = "FF$hexColor";
    return Color(int.parse("0x$hexColor"));
  }
}
