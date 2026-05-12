# Theme Extension Implementation Summary

## What Was Implemented

A Flutter-native `ThemeExtension`-based approach for accessing theme colors that automatically adapts to light/dark modes.

## Files Created

1. **`app_colors_extension.dart`** (114 lines)
   - `AppColorsExtension` class extending `ThemeExtension`
   - Static `light` and `dark` constants
   - Implements `copyWith()` and `lerp()` for theme animation support

2. **`app_colors_context_extension.dart`** (14 lines)
   - `AppColorsContextExtension` on `BuildContext`
   - Provides `context.appColors` shorthand
   - Falls back to light theme if extension not found

# Color Guide - Material 3 + Custom Design Shades

## Overview

This project uses a Flutter `ThemeExtension` so you can work with both:

1. **Material 3 semantic colors** — for standard app surfaces, text, borders, and state colors.
2. **Custom designer palettes and shades** — for brand colors or exact visual tones that do not follow Material 3 strictly.

The goal is to keep one theme system, while still allowing custom colors whenever the design needs them.

---

## Main Access Pattern

Use `AppColorsExtension` as the theme source and `context.appColors` as the widget shortcut:

```dart
import 'package:flutter_template/core/theme/app_colors_context_extension.dart';

Container(
  color: context.appColors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: context.appColors.textPrimary),
  ),
)
```

If you do not have `BuildContext`, use the theme instances directly:

```dart
final lightPrimary = AppColorsExtension.light.primary;
final darkPrimary = AppColorsExtension.dark.primary;
```

---

## Two Color Layers

### 1) Semantic colors

Use these for the overall app theme:

- `primary`
- `secondary`
- `tertiary`
- `error`
- `success`
- `background`
- `surface`
- `surfaceVariant`
- `textPrimary`
- `textSecondary`
- `textDisabled`
- `border`

These adapt automatically to light and dark mode.

### 2) Palette shades

Use these when the designer wants a specific tone or shade:

- `primaryPalette`
- `secondaryPalette`
- `tertiaryPalette`
- `errorPalette`
- `successPalette`
- `neutralPalette`

Example shade usage:

```dart
context.appColors.primaryPalette.shade100
context.appColors.primaryPalette.shade500
context.appColors.primaryPalette.shade900
```

This is useful when Material 3 colors are not enough and the design needs more custom branding control.

---

## When to Use What

### Use semantic colors when:

- You want standard theme behavior.
- The element should adapt naturally to dark mode.
- You are styling buttons, surfaces, text, borders, or alert states.

Example:

```dart
Container(
  color: context.appColors.surface,
  child: Text(
    'Title',
    style: TextStyle(color: context.appColors.textPrimary),
  ),
)
```

### Use palette shades when:

- The designer gives you a specific custom shade.
- You need a lighter or darker variation of the brand color.
- The UI requires tones outside of the Material 3 default flow.

Example:

```dart
Container(
  color: context.appColors.primaryPalette.shade50,
  child: Icon(
    Icons.star,
    color: context.appColors.primaryPalette.shade700,
  ),
)
```

---

## How It Works

1. `AppLightColors` and `AppDarkColors` hold the actual design tokens.
2. `AppColorsExtension.light` and `AppColorsExtension.dark` wrap those tokens.
3. `theme_data.dart` adds the extension into `ThemeData.extensions`.
4. `context.appColors` reads the current extension from Flutter’s theme system.

So the app always gets the correct colors for the active theme.

---

## Material 3 + Custom Shades Together

This project does **not** force designers to use Material 3 only.

Instead:

- Use **semantic colors** for consistent app UI.
- Use **palette shades** when the design needs specific tones.

This gives you:

- a clean theme system
- flexible custom branding
- easy dark mode support

---

## Examples

### Material 3 style button

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: context.appColors.primary,
    foregroundColor: Colors.white,
  ),
  onPressed: () {},
  child: const Text('Submit'),
)
```

### Custom shade background

```dart
Container(
  color: context.appColors.primaryPalette.shade100,
  child: Text(
    'Custom brand shade',
    style: TextStyle(color: context.appColors.primaryPalette.shade900),
  ),
)
```

### Border with neutral palette

```dart
Container(
  decoration: BoxDecoration(
    border: Border.all(color: context.appColors.neutralPalette.shade200),
  ),
)
```

---

## Theme Setup

The extension is already added in `theme_data.dart`:

```dart
ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    AppColorsExtension.light,
  ],
)
```

and for dark mode:

```dart
ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    AppColorsExtension.dark,
  ],
)
```

---

## Recommended Pattern

### In widgets

Use:

```dart
context.appColors.primary
```

or a shade:

```dart
context.appColors.primaryPalette.shade500
```

### In non-UI code

Use:

```dart
AppColorsExtension.light.primary
```

or:

```dart
AppColorsExtension.dark.primary
```

---

## Migration Notes

### Before

```dart
color: AppLightColors.primary
```

### After

```dart
color: context.appColors.primary
```

### Before

```dart
color: AppLightColors.primaryPalette.shade100
```

### After

```dart
color: context.appColors.primaryPalette.shade100
```

---

## Best Practices

1. Use semantic colors for most UI.
2. Use palette shades when designers need custom tones.
3. Prefer `context.appColors` inside widgets.
4. Use `AppColorsExtension.light` or `.dark` only when `BuildContext` is not available.
5. Keep custom palette usage intentional and consistent.