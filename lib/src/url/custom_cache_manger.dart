import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final HashMap<_CacheOption, CacheManager> hashMap =
    HashMap<_CacheOption, CacheManager>();

class CustomCacheManger extends CacheManager {
  factory CustomCacheManger({
    @required String key,
    @required Duration maxAgeCacheObject,
    @required int maxNrOfCacheObjects,
  }) {
    final _CacheOption cacheOption = _CacheOption(
      key: key,
      maxAgeCacheObject: maxAgeCacheObject,
      maxNrOfCacheObjects: maxNrOfCacheObjects,
    );

    if (!hashMap.containsKey(cacheOption)) {
      hashMap[cacheOption] = CustomCacheManger._(cacheOption);
    }
    return hashMap[cacheOption] as CustomCacheManger;
  }

  CustomCacheManger._(_CacheOption cacheOption)
      : super(Config(
          cacheOption.key,
          stalePeriod: cacheOption.maxAgeCacheObject,
          maxNrOfCacheObjects: cacheOption.maxNrOfCacheObjects,
        ));
}

@immutable
class _CacheOption {
  const _CacheOption(
      {this.key, this.maxAgeCacheObject, this.maxNrOfCacheObjects});

  final String key;

  final Duration maxAgeCacheObject;
  final int maxNrOfCacheObjects;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _CacheOption &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          maxAgeCacheObject == other.maxAgeCacheObject &&
          maxNrOfCacheObjects == other.maxNrOfCacheObjects;

  @override
  int get hashCode =>
      key.hashCode ^ maxAgeCacheObject.hashCode ^ maxNrOfCacheObjects.hashCode;

  @override
  String toString() {
    return 'CacheOption{key: $key, maxAgeCacheObject: $maxAgeCacheObject, maxNrOfCacheObjects: $maxNrOfCacheObjects}';
  }
}
