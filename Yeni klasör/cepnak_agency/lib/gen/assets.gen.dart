/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cepnak_splash.png
  AssetGenImage get cepnakSplash =>
      const AssetGenImage('assets/images/cepnak_splash.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.png');

  /// File path: assets/images/rightcodelogo.png
  AssetGenImage get rightcodelogo =>
      const AssetGenImage('assets/images/rightcodelogo.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [cepnakSplash, logo, profile, rightcodelogo];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/bigdriver.png
  AssetGenImage get bigdriver =>
      const AssetGenImage('assets/png/bigdriver.png');

  /// File path: assets/png/bighome.png
  AssetGenImage get bighome => const AssetGenImage('assets/png/bighome.png');

  /// File path: assets/png/business.png
  AssetGenImage get business => const AssetGenImage('assets/png/business.png');

  /// File path: assets/png/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/png/empty.png');

  /// File path: assets/png/home.png
  AssetGenImage get home => const AssetGenImage('assets/png/home.png');

  /// File path: assets/png/logocepnak.png
  AssetGenImage get logocepnak =>
      const AssetGenImage('assets/png/logocepnak.png');

  /// File path: assets/png/person.png
  AssetGenImage get person => const AssetGenImage('assets/png/person.png');

  /// File path: assets/png/personbig.png
  AssetGenImage get personbig =>
      const AssetGenImage('assets/png/personbig.png');

  /// File path: assets/png/transit.png
  AssetGenImage get transit => const AssetGenImage('assets/png/transit.png');

  /// File path: assets/png/truck.png
  AssetGenImage get truck => const AssetGenImage('assets/png/truck.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        bigdriver,
        bighome,
        business,
        empty,
        home,
        logocepnak,
        person,
        personbig,
        transit,
        truck
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsPngGen png = $AssetsPngGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
