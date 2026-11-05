# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.4] - 2026-11-05

### Added
- Exported `InlineStyle`, `GlobalDialog`, `DrawerRouter`, `DrawerRouterStack`, `Responsive`, `NewScrollBehavior`, `OverScrollBehavior` and `DashedBorder` from the package entry.
- Added recommended `onChanged` aliases to `KitSwitch`, `KitCheckBox`, `Pager`, `RatingBar`, `CustomAnimatedBottomBar` and the `DatePicker` static helpers.
- Added a shared popup layout implementation for `SelectionMenu` and `SelectionMenuForm`.
- Added unit and widget tests, plus GitHub Actions CI.

### Fixed
- Fixed the built-in city data asset path in `CityPickerView`.
- Fixed `EventSubscriber.dispose()` clearing the global event bus.
- Fixed `TimeView` firing completion callbacks during `initState` and failing to complete one-second countdowns.
- Fixed `SplashBobbleAnimation` crashing for arbitrary start angles.
- Fixed `SelectionMenu`/`SelectionMenuForm` closing the host route when the popup was not open.
- Fixed controlled `KitSwitch`, `KitCheckBox` and `ImageSwitch` not syncing external values.
- Fixed resource leaks in `Radar5DimensionsChart`, `InputExtend`, `InfiniteLevelsMenus`, `Pager` and `DragBox`.
- Fixed `MultiSelectorEntity.formJson` type unsafety and added `fromJson`.
- Fixed `LinearProgressBar` assertions that were always true.
- Fixed `DatePicker` disposing externally owned controllers and ignoring bottom sheet parameters.
- Fixed `TableExtend` ignoring updated data and several dead parameters.
- Fixed `Shimmer` continuing to animate after loading finished.
- Fixed `MeasureUtils.measureTextSize` limiting text to 29 lines.
- Fixed `PagerTheme` values not being applied.

### Changed
- Clarified the package SDK constraints (`Dart >=3.6.0`, `Flutter >=3.27.0`).
- Removed the plugin scaffold from `pubspec.yaml` and added pub.dev metadata.
- Aligned the example project SDK constraints and lint version.
- Updated README installation snippets and fixed broken image links.
- Expanded the example app into a categorized component gallery covering basic controls, progress bars, buttons and popups, multi-selection, drag, navigation, responsive layout and rotation animations.

## [0.4.3]
### Added
- `InputValidation`: Added 10+ built-in validators (email, phone, URL, ID card, number, etc.), combination validation, and conditional validation.
- `SplashBobbleAnimation`: Added custom bubble colors, scale factor, and curve parameters for better animation control.
- `KitCheckBox`: Added tri-state support (indeterminate state), haptic feedback, and custom indeterminate icon.
- `KitSwitch`: Added haptic feedback functionality.
- `CustomAnimatedBottomBar`: Added badge display support for unread message counts and haptic feedback.
- `MarqueeView`: Added controller for external pause/resume control.
- `RatingBar`: Added value formatter parameter for custom display format.
- `TimeView`: Added pause/resume control, progress tracking, auto-restart, and enhanced callbacks.
- `Pager`: Added theme system with 4 built-in themes (default, blue, green, dark) and theme customization support.

### Fixed
- Fixed `LinearProgressBar` immutable field warnings.
- Fixed `DrawerRouter` deprecated API usage (`onPopInvoked` → `onPopInvokedWithResult`).
- Fixed Web platform compatibility issues with conditional imports for `dart:io`.

### Changed
- Enhanced component documentation with comprehensive examples and usage notes.
- All examples and documentation are now in component header comments.
- Improved bilingual documentation (English/Chinese).

## [0.4.2]
- Partial component refactoring and code optimization.

## [0.4.1]
- A lot of component optimizations, and add example instructions.

## [0.4.0]
- A large number of component refactoring and optimizing, removing some components.

## [0.3.1]
- Upgrade Flutter SDK version 3.27.4.

## [0.2.1]
- Fixing bugs and component optimization.

## [0.2.0]
- New components and version optimization.