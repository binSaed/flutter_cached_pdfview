# flutter_cached_pdfview 


![Pub Version](https://img.shields.io/pub/v/flutter_cached_pdfview?color=1&label=flutter_cached_pdfview)
![GitHub repo size](https://img.shields.io/github/repo-size/AbdOoSaed/flutter_cached_pdfview)
![issues-raw](https://img.shields.io/github/issues-raw/AbdOoSaed/flutter_cached_pdfview)
![license](https://img.shields.io/github/license/AbdOoSaed/flutter_cached_pdfview)
![last-commit](https://img.shields.io/github/last-commit/AbdOoSaed/flutter_cached_pdfview)
![stars](https://img.shields.io/github/stars/AbdOoSaed/flutter_cached_pdfview?style=social)
<p align="center">
    <a href="https://pub.dev/packages/flutter_cached_pdfview">
   <img src="https://firebasestorage.googleapis.com/v0/b/iam-jobs.appspot.com/o/flutter_cached_pdfview.png?alt=media&token=853143c0-250d-4647-840d-98f11d25dbb5">
    </a>
    <br>A package to show Native PDF View for iOS and Android, support Open from a different resource like Path, Asset or Url and Cache it.
   
* Support Open Pdf From Path
* Support Open Pdf From Asset
* Support Open Pdf From URl and Cache it
---
### 3. Setup

#### iOS
Opt-in to the embedded views preview by adding a boolean property to the app's `Info.plist` file
with the key `io.flutter.embedded_views_preview` and the value `YES`.

[ready-made in the [Example](https://github.com/AbdOoSaed/flutter_cached_pdfview/tree/master/example)

### 4. Import it

Now in your Dart code, you can use:

```
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
```

## Options

| Name               | Android | iOS |      Default      |
| :----------------- | :-----: | :-: | :---------------: |
| defaultPage        |   ✅    | ✅  |        `0`        |
| onViewCreated      |   ✅    | ✅  |      `null`       |
| onRender           |   ✅    | ✅  |      `null`       |
| onPageChanged      |   ✅    | ✅  |      `null`       |
| onError            |   ✅    | ✅  |      `null`       |
| onPageError        |   ✅    | ❌  |      `null`       |
| gestureRecognizers |   ✅    | ✅  |      `null`       |
| filePath           |   ✅    | ✅  |                   |
| fitPolicy          |   ✅    | ❌  | `FitPolicy.WIDTH` |
| enableSwipe        |   ✅    | ✅  |      `true`       |
| swipeHorizontal    |   ✅    | ✅  |      `false`      |
| password           |   ✅    | ✅  |      `null`       |
| nightMode          |   ✅    | ❌  |      `false`      |
| password           |   ✅    | ✅  |      `null`       |
| autoSpacing        |   ✅    | ✅  |      `true`       |
| pageFling          |   ✅    | ✅  |      `true`       |
| pageSnap           |   ✅    | ❌  |      `true`       |

## Controller Options

| Name           |     Description      | Parameters |     Return     |
| :------------- | :------------------: | :--------: | :------------: |
| getPageCount   | Get total page count |     -      | `Future<int>`  |
| getCurrentPage |   Get current page   |     -      | `Future<int>`  |
| setPage        |    Go to/Set page    | `int page` | `Future<bool>` |

## [Example](https://github.com/AbdOoSaed/flutter_cached_pdfview/tree/master/example)
####from Asset
```dart
       PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onPageChanged: (int page, int total) {
          print('page change: $page/$total');
        },
      ).fromAsset('assets/pdf/file-example.pdf'),

```
####cached From Url
```dart
      PDF(
        swipeHorizontal: true,
      ).cachedFromUrl('http://africau.edu/images/default/sample.pdf'),

```

# For production usage

If you use proguard, you should include this line [ready-made in the [Example](https://github.com/AbdOoSaed/flutter_cached_pdfview/tree/master/example)].

```
-keep class com.shockwave.**
```

# Dependencies

### Flutter

[flutter_pdfview](https://pub.dev/packages/flutter_pdfview)

[flutter_cache_manager](https://pub.dev/packages/flutter_cache_manager)

### Android

[AndroidPdfViewer](https://github.com/barteksc/AndroidPdfViewer)

### iOS (only support> 11.0)

[PDFKit](https://developer.apple.com/documentation/pdfkit)

# Support

<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
  <input type="hidden" name="cmd" value="_s-xclick" />
  <input type="hidden" name="hosted_button_id" value="YDEYAAGBXDDK6" />
  <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" />
  <img alt="" border="0" src="https://www.paypal.com/en_MN/i/scr/pixel.gif" width="1" height="1" />
</form>

### Developer

- [Abdelrahman Saed](https://github.com/AbdOoSaed)


# Support
<p align="center">
    <a href="https://www.paypal.me/abdoosaed/5">
   <img height=85 src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" >
    </a>
    <br>    buy me a coffee by PayPal
</p>
