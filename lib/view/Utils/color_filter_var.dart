import 'dart:ui';

class ColorFilters{
  static const List<ColorFilter> colorFilters = [
    original,
    sepia,
    grayscale,
    invert,
    brightnessIncrease,
    brightnessDecrease,
    highContrast,
    lowContrast,
    redTint,
    greenTint,
    blueTint,
    yellowTint,
    purpleTint,
    cyanTint,
    orangeTint,
    lighten,
    darken,
    highSaturation,
    lowSaturation,
    mutedRed,
    mutedGreen,
    mutedBlue,
    warmFilter,
    coolFilter,
    blackAndWhite,
    negativeRed,
    negativeGreen,
    negativeBlue,
    yellowTintSoft,
    purpleTintSoft,
    redBoostHigh,
    greenBoostHigh,
    blueBoostHigh,
    warmBoost,
    coolBoost,
    lightSepia,
    deepSepia,
    vintageBlue,
    vintageGreen,
    brightLowSaturation,
    darkHighSaturation,
    softGrayscale,
    tealTint,
    pinkTint,
    desaturate,
    highContrastMono,
    vibrantYellowBoost,
    brightCyanBoost,
    goldenGlow,
  ];

  // Original
  static const ColorFilter original = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Sepia
  static const ColorFilter sepia = ColorFilter.matrix(<double>[
    0.393, 0.769, 0.189, 0, 0,
    0.349, 0.686, 0.168, 0, 0,
    0.272, 0.534, 0.131, 0, 0,
    0,     0,     0,     1, 0,
  ]);

// Grayscale
  static const ColorFilter grayscale = ColorFilter.matrix(<double>[
    0.3, 0.59, 0.11, 0, 0,
    0.3, 0.59, 0.11, 0, 0,
    0.3, 0.59, 0.11, 0, 0,
    0,   0,    0,    1, 0,
  ]);

// Invert Colors
  static const ColorFilter invert = ColorFilter.matrix(<double>[
    -1, 0, 0, 0, 255,
    0, -1, 0, 0, 255,
    0, 0, -1, 0, 255,
    0, 0, 0, 1, 0,
  ]);

// Brightness Increase
  static const ColorFilter brightnessIncrease = ColorFilter.matrix(<double>[
    1.2, 0, 0, 0, 0,
    0, 1.2, 0, 0, 0,
    0, 0, 1.2, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Brightness Decrease
  static const ColorFilter brightnessDecrease = ColorFilter.matrix(<double>[
    0.8, 0, 0, 0, 0,
    0, 0.8, 0, 0, 0,
    0, 0, 0.8, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// High Contrast
  static const ColorFilter highContrast = ColorFilter.matrix(<double>[
    1.5, 0, 0, 0, -50,
    0, 1.5, 0, 0, -50,
    0, 0, 1.5, 0, -50,
    0, 0, 0, 1, 0,
  ]);

// Low Contrast
  static const ColorFilter lowContrast = ColorFilter.matrix(<double>[
    0.5, 0, 0, 0, 50,
    0, 0.5, 0, 0, 50,
    0, 0, 0.5, 0, 50,
    0, 0, 0, 1, 0,
  ]);

// Red Tint
  static const ColorFilter redTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 50,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Green Tint
  static const ColorFilter greenTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 50,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Blue Tint
  static const ColorFilter blueTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 50,
    0, 0, 0, 1, 0,
  ]);

// Yellow Tint
  static const ColorFilter yellowTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 50,
    0, 1, 0, 0, 50,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Purple Tint
  static const ColorFilter purpleTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 50,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 50,
    0, 0, 0, 1, 0,
  ]);

// Cyan Tint
  static const ColorFilter cyanTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 50,
    0, 0, 1, 0, 50,
    0, 0, 0, 1, 0,
  ]);

// Orange Tint
  static const ColorFilter orangeTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 50,
    0, 1, 0, 0, 25,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Lighten
  static const ColorFilter lighten = ColorFilter.matrix(<double>[
    1.3, 0, 0, 0, 0,
    0, 1.3, 0, 0, 0,
    0, 0, 1.3, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Darken
  static const ColorFilter darken = ColorFilter.matrix(<double>[
    0.6, 0, 0, 0, 0,
    0, 0.6, 0, 0, 0,
    0, 0, 0.6, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// High Saturation
  static const ColorFilter highSaturation = ColorFilter.matrix(<double>[
    1.5, -0.5, -0.5, 0, 0,
    -0.5, 1.5, -0.5, 0, 0,
    -0.5, -0.5, 1.5, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Low Saturation
  static const ColorFilter lowSaturation = ColorFilter.matrix(<double>[
    0.5, 0.5, 0.5, 0, 0,
    0.5, 0.5, 0.5, 0, 0,
    0.5, 0.5, 0.5, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Muted Red
  static const ColorFilter mutedRed = ColorFilter.matrix(<double>[
    0.7, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Muted Green
  static const ColorFilter mutedGreen = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 0.7, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Muted Blue
  static const ColorFilter mutedBlue = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 0.7, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Warm Filter
  static const ColorFilter warmFilter = ColorFilter.matrix(<double>[
    1.2, 0, 0, 0, 20,
    0, 1, 0, 0, 0,
    0, 0, 0.8, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Cool Filter
  static const ColorFilter coolFilter = ColorFilter.matrix(<double>[
    0.9, 0, 0, 0, 0,
    0, 1, 0, 0, 10,
    0, 0, 1.2, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Black and White
  static const ColorFilter blackAndWhite = ColorFilter.matrix(<double>[
    0.5, 0.5, 0.5, 0, 0,
    0.5, 0.5, 0.5, 0, 0,
    0.5, 0.5, 0.5, 0, 0,
    0,   0,   0,   1, 0,
  ]);

// Negative Red
  static const ColorFilter negativeRed = ColorFilter.matrix(<double>[
    -1, 0, 0, 0, 255,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Negative Green
  static const ColorFilter negativeGreen = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, -1, 0, 0, 255,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Negative Blue
  static const ColorFilter negativeBlue = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, -1, 0, 255,
    0, 0, 0, 1, 0,
  ]);

// Yellow Tint Soft
  static const ColorFilter yellowTintSoft = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 20,
    0, 1, 0, 0, 20,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Purple Tint Soft
  static const ColorFilter purpleTintSoft = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 20,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 20,
    0, 0, 0, 1, 0,
  ]);

// Red Boost High
  static const ColorFilter redBoostHigh = ColorFilter.matrix(<double>[
    1.5, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Green Boost High
  static const ColorFilter greenBoostHigh = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1.5, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Blue Boost High
  static const ColorFilter blueBoostHigh = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1.5, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Warm Boost
  static const ColorFilter warmBoost = ColorFilter.matrix(<double>[
    1.3, 0, 0, 0, 0,
    0, 1.2, 0, 0, 0,
    0, 0, 0.9, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Cool Boost
  static const ColorFilter coolBoost = ColorFilter.matrix(<double>[
    0.9, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1.3, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Light Sepia
  static const ColorFilter lightSepia = ColorFilter.matrix(<double>[
    0.9, 0.2, 0.2, 0, 0,
    0.3, 0.8, 0.2, 0, 0,
    0.2, 0.3, 0.7, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Deep Sepia
  static const ColorFilter deepSepia = ColorFilter.matrix(<double>[
    0.7, 0.4, 0.1, 0, 0,
    0.3, 0.7, 0.1, 0, 0,
    0.2, 0.2, 0.6, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Vintage Blue
  static const ColorFilter vintageBlue = ColorFilter.matrix(<double>[
    0.7, 0.2, 0.2, 0, 0,
    0.2, 0.5, 0.2, 0, 0,
    0.2, 0.4, 0.7, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Vintage Green
  static const ColorFilter vintageGreen = ColorFilter.matrix(<double>[
    0.6, 0.2, 0.1, 0, 0,
    0.3, 0.6, 0.1, 0, 0,
    0.1, 0.2, 0.6, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// High Brightness and Low Saturation
  static const ColorFilter brightLowSaturation = ColorFilter.matrix(<double>[
    1.2, 0.2, 0.2, 0, 0,
    0.2, 1.2, 0.2, 0, 0,
    0.2, 0.2, 1.2, 0, 0,
    0,   0,   0,   1, 0,
  ]);

// Low Brightness and High Saturation
  static const ColorFilter darkHighSaturation = ColorFilter.matrix(<double>[
    1.3, -0.2, -0.2, 0, 0,
    -0.2, 1.3, -0.2, 0, 0,
    -0.2, -0.2, 1.3, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Soft Grayscale
  static const ColorFilter softGrayscale = ColorFilter.matrix(<double>[
    0.6, 0.3, 0.1, 0, 0,
    0.3, 0.6, 0.1, 0, 0,
    0.1, 0.3, 0.6, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Teal Tint
  static const ColorFilter tealTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 30,
    0, 0, 1, 0, 50,
    0, 0, 0, 1, 0,
  ]);

// Pink Tint
  static const ColorFilter pinkTint = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 50,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 50,
    0, 0, 0, 1, 0,
  ]);

// Desaturate (Muted Colors)
  static const ColorFilter desaturate = ColorFilter.matrix(<double>[
    0.5, 0.5, 0.5, 0, 0,
    0.5, 0.5, 0.5, 0, 0,
    0.5, 0.5, 0.5, 0, 0,
    0,   0,   0,   1, 0,
  ]);

// High Contrast Monochrome
  static const ColorFilter highContrastMono = ColorFilter.matrix(<double>[
    1.5, 0.5, 0.5, 0, 0,
    0.5, 1.5, 0.5, 0, 0,
    0.5, 0.5, 1.5, 0, 0,
    0,   0,   0,   1, 0,
  ]);

// Vibrant Yellow Boost
  static const ColorFilter vibrantYellowBoost = ColorFilter.matrix(<double>[
    1, 0.3, 0, 0, 50,
    0, 1, 0, 0, 50,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);

// Bright Cyan Boost
  static const ColorFilter brightCyanBoost = ColorFilter.matrix(<double>[
    1, 0, 0.3, 0, 0,
    0, 1, 0.3, 0, 50,
    0, 0, 1, 0, 50,
    0, 0, 0, 1, 0,
  ]);

// Golden Glow
  static const ColorFilter goldenGlow = ColorFilter.matrix(<double>[
    1.2, 0.6, 0.2, 0, 20,
    0.3, 1, 0.1, 0, 20,
    0.2, 0.3, 1.3, 0, 20,
    0, 0, 0, 1, 0,
  ]);


}