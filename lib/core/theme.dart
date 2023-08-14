import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFB62500),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFDAD2),
  onPrimaryContainer: Color(0xFF3D0600),
  secondary: Color(0xFF77574F),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFDAD2),
  onSecondaryContainer: Color(0xFF2C1510),
  tertiary: Color(0xFF6D5D2E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFF8E1A6),
  onTertiaryContainer: Color(0xFF241A00),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF201A19),
  outline: Color(0xFF85736F),
  onInverseSurface: Color(0xFFFBEEEB),
  inverseSurface: Color(0xFF362F2D),
  inversePrimary: Color(0xFFFFB4A3),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB62500),
  outlineVariant: Color(0xFFD8C2BD),
  scrim: Color(0xFF000000),
  surface: Color(0xFFFFF8F6),
  onSurface: Color(0xFF201A19),
  surfaceVariant: Color(0xFFF5DDD8),
  onSurfaceVariant: Color(0xFF534340),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFFB4A3),
  onPrimary: Color(0xFF630F00),
  primaryContainer: Color(0xFF8B1A00),
  onPrimaryContainer: Color(0xFFFFDAD2),
  secondary: Color(0xFFE7BDB4),
  onSecondary: Color(0xFF442A23),
  secondaryContainer: Color(0xFF5D3F39),
  onSecondaryContainer: Color(0xFFFFDAD2),
  tertiary: Color(0xFFDBC58C),
  onTertiary: Color(0xFF3C2F04),
  tertiaryContainer: Color(0xFF544519),
  onTertiaryContainer: Color(0xFFF8E1A6),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF201A19),
  onBackground: Color(0xFFEDE0DD),
  outline: Color(0xFFA08C88),
  onInverseSurface: Color(0xFF201A19),
  inverseSurface: Color(0xFFEDE0DD),
  inversePrimary: Color(0xFFB62500),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFFFB4A3),
  outlineVariant: Color(0xFF534340),
  scrim: Color(0xFF000000),
  surface: Color(0xFF181211),
  onSurface: Color(0xFFD0C4C1),
  surfaceVariant: Color(0xFF534340),
  onSurfaceVariant: Color(0xFFD8C2BD),
);

Color pemasukanColor = const Color(0xff16A813);
Color pengeluaranColor = const Color(0xffEF6461);

TextStyle logoTextStyle = GoogleFonts.jua(
  color: const Color(0xFFFF4A21),
  fontSize: 44,
);

TextStyle headerTextStyle = GoogleFonts.roboto(
  color: lightColorScheme.onSurface,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

TextStyle pemasukanStyle =
    GoogleFonts.roboto(color: pemasukanColor, fontWeight: FontWeight.bold);

TextStyle pengeluaranStyle =
    GoogleFonts.roboto(color: pengeluaranColor, fontWeight: FontWeight.bold);
