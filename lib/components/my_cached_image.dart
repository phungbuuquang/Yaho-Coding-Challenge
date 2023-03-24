import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:yahoapp/themes/app_colors.dart';

class MyCachedImage extends StatelessWidget {
  const MyCachedImage(
    this.imgUrl, {
    super.key,
    this.height,
    this.width,
  });
  final String imgUrl;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imgUrl,
      width: width,
      height: height,
      placeholder: (context, url) => Container(
        height: height,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColorLight.primary,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
      ),
      cacheManager: CustomCacheManager.instance,
    );
  }
}

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
    ),
  );
}
