import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

final HashMap<_CacheOption, BaseCacheManager> mapSingleton =
    HashMap<_CacheOption, BaseCacheManager>();

class CustomCacheManger extends BaseCacheManager {
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

    if (!mapSingleton.containsKey(cacheOption)) {
      mapSingleton[cacheOption] = CustomCacheManger._(cacheOption);
    }
    return mapSingleton[cacheOption] as CustomCacheManger;
  }

  CustomCacheManger._(this._cacheOption)
      : super(_cacheOption.key,
            maxAgeCacheObject: _cacheOption.maxAgeCacheObject,
            maxNrOfCacheObjects: _cacheOption.maxNrOfCacheObjects);
  final _CacheOption _cacheOption;

  @override
  Future<String> getFilePath() async {
    final Directory directory = await getTemporaryDirectory();
    return p.join(directory.path, _cacheOption.key);
  }
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
