import "../widgets/export_packages.dart";


TextStyle appStyle({required double size, required Color color, required FontWeight fw}) {
  return GoogleFonts.poppins(fontSize: size.sp, color: color, fontWeight: fw);
}

TextStyle appStyleWithHt({required double size, required Color color, required FontWeight fw, required double ht}) {
  return GoogleFonts.poppins(fontSize: size.sp, color: color, fontWeight: fw, height: ht);
}