import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff894a67),
      surfaceTint: Color(0xff894a67),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffd8e6),
      onPrimaryContainer: Color(0xff6e334f),
      secondary: Color(0xff00687b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffaeecff),
      onSecondaryContainer: Color(0xff004e5d),
      tertiary: Color(0xff815512),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffddb6),
      onTertiaryContainer: Color(0xff643f00),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffdf9ec),
      onSurface: Color(0xff1c1c14),
      onSurfaceVariant: Color(0xff3f484b),
      outline: Color(0xff6f797b),
      outlineVariant: Color(0xffbfc8cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323128),
      inversePrimary: Color(0xfffeb0d1),
      primaryFixed: Color(0xffffd8e6),
      onPrimaryFixed: Color(0xff390723),
      primaryFixedDim: Color(0xfffeb0d1),
      onPrimaryFixedVariant: Color(0xff6e334f),
      secondaryFixed: Color(0xffaeecff),
      onSecondaryFixed: Color(0xff001f26),
      secondaryFixedDim: Color(0xff85d2e7),
      onSecondaryFixedVariant: Color(0xff004e5d),
      tertiaryFixed: Color(0xffffddb6),
      onTertiaryFixed: Color(0xff2a1800),
      tertiaryFixedDim: Color(0xfff6bc70),
      onTertiaryFixedVariant: Color(0xff643f00),
      surfaceDim: Color(0xffdedacd),
      surfaceBright: Color(0xfffdf9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f4e6),
      surfaceContainer: Color(0xfff2eee0),
      surfaceContainerHigh: Color(0xffece8db),
      surfaceContainerHighest: Color(0xffe6e2d5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5a233e),
      surfaceTint: Color(0xff894a67),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9a5976),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003c48),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff1f778a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4e3000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff926420),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf9ec),
      onSurface: Color(0xff12110a),
      onSurfaceVariant: Color(0xff2f383a),
      outline: Color(0xff4b5456),
      outlineVariant: Color(0xff656f71),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323128),
      inversePrimary: Color(0xfffeb0d1),
      primaryFixed: Color(0xff9a5976),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff7e415e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff1f778a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff005d6e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff926420),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff764c07),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcac7ba),
      surfaceBright: Color(0xfffdf9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f4e6),
      surfaceContainer: Color(0xffece8db),
      surfaceContainerHigh: Color(0xffe0ddd0),
      surfaceContainerHighest: Color(0xffd5d2c5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4d1934),
      surfaceTint: Color(0xff894a67),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff703652),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00313b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff005160),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff402700),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff674100),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf9ec),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252e30),
      outlineVariant: Color(0xff424b4d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff323128),
      inversePrimary: Color(0xfffeb0d1),
      primaryFixed: Color(0xff703652),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff551f3b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff005160),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003843),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff674100),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff492c00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbcb9ac),
      surfaceBright: Color(0xfffdf9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f1e3),
      surfaceContainer: Color(0xffe6e2d5),
      surfaceContainerHigh: Color(0xffd8d4c7),
      surfaceContainerHighest: Color(0xffcac7ba),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffeb0d1),
      surfaceTint: Color(0xfffeb0d1),
      onPrimary: Color(0xff531d38),
      primaryContainer: Color(0xff6e334f),
      onPrimaryContainer: Color(0xffffd8e6),
      secondary: Color(0xff85d2e7),
      onSecondary: Color(0xff003641),
      secondaryContainer: Color(0xff004e5d),
      onSecondaryContainer: Color(0xffaeecff),
      tertiary: Color(0xfff6bc70),
      onTertiary: Color(0xff462a00),
      tertiaryContainer: Color(0xff643f00),
      onTertiaryContainer: Color(0xffffddb6),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff14140c),
      onSurface: Color(0xffe6e2d5),
      onSurfaceVariant: Color(0xffbfc8cb),
      outline: Color(0xff899295),
      outlineVariant: Color(0xff3f484b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2d5),
      inversePrimary: Color(0xff894a67),
      primaryFixed: Color(0xffffd8e6),
      onPrimaryFixed: Color(0xff390723),
      primaryFixedDim: Color(0xfffeb0d1),
      onPrimaryFixedVariant: Color(0xff6e334f),
      secondaryFixed: Color(0xffaeecff),
      onSecondaryFixed: Color(0xff001f26),
      secondaryFixedDim: Color(0xff85d2e7),
      onSecondaryFixedVariant: Color(0xff004e5d),
      tertiaryFixed: Color(0xffffddb6),
      onTertiaryFixed: Color(0xff2a1800),
      tertiaryFixedDim: Color(0xfff6bc70),
      onTertiaryFixedVariant: Color(0xff643f00),
      surfaceDim: Color(0xff14140c),
      surfaceBright: Color(0xff3b3930),
      surfaceContainerLowest: Color(0xff0f0e07),
      surfaceContainerLow: Color(0xff1c1c14),
      surfaceContainer: Color(0xff212018),
      surfaceContainerHigh: Color(0xff2b2a22),
      surfaceContainerHighest: Color(0xff36352c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd0e1),
      surfaceTint: Color(0xfffeb0d1),
      onPrimary: Color(0xff45122d),
      primaryContainer: Color(0xffc37b9b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff9be8fe),
      onSecondary: Color(0xff002a33),
      secondaryContainer: Color(0xff4c9bb0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd5a4),
      onTertiary: Color(0xff382100),
      tertiaryContainer: Color(0xffba8741),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff14140c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd5dee0),
      outline: Color(0xffaab3b6),
      outlineVariant: Color(0xff899294),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2d5),
      inversePrimary: Color(0xff6f3451),
      primaryFixed: Color(0xffffd8e6),
      onPrimaryFixed: Color(0xff2a0018),
      primaryFixedDim: Color(0xfffeb0d1),
      onPrimaryFixedVariant: Color(0xff5a233e),
      secondaryFixed: Color(0xffaeecff),
      onSecondaryFixed: Color(0xff001419),
      secondaryFixedDim: Color(0xff85d2e7),
      onSecondaryFixedVariant: Color(0xff003c48),
      tertiaryFixed: Color(0xffffddb6),
      onTertiaryFixed: Color(0xff1c0e00),
      tertiaryFixedDim: Color(0xfff6bc70),
      onTertiaryFixedVariant: Color(0xff4e3000),
      surfaceDim: Color(0xff14140c),
      surfaceBright: Color(0xff46453b),
      surfaceContainerLowest: Color(0xff080803),
      surfaceContainerLow: Color(0xff1f1e16),
      surfaceContainer: Color(0xff292820),
      surfaceContainerHigh: Color(0xff34332a),
      surfaceContainerHighest: Color(0xff3f3e35),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffebf1),
      surfaceTint: Color(0xfffeb0d1),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xfffaaccd),
      onPrimaryContainer: Color(0xff200011),
      secondary: Color(0xffd7f5ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff81cee3),
      onSecondaryContainer: Color(0xff000d12),
      tertiary: Color(0xffffeddb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff2b86c),
      onTertiaryContainer: Color(0xff140900),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff14140c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2f4),
      outlineVariant: Color(0xffbbc4c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2d5),
      inversePrimary: Color(0xff6f3451),
      primaryFixed: Color(0xffffd8e6),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xfffeb0d1),
      onPrimaryFixedVariant: Color(0xff2a0018),
      secondaryFixed: Color(0xffaeecff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff85d2e7),
      onSecondaryFixedVariant: Color(0xff001419),
      tertiaryFixed: Color(0xffffddb6),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfff6bc70),
      onTertiaryFixedVariant: Color(0xff1c0e00),
      surfaceDim: Color(0xff14140c),
      surfaceBright: Color(0xff525046),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff212018),
      surfaceContainer: Color(0xff323128),
      surfaceContainerHigh: Color(0xff3d3c32),
      surfaceContainerHighest: Color(0xff48473d),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
