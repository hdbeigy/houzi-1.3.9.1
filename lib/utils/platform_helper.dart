import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformHelper {
  static bool get isAndroid {
    if (kIsWeb) return false;
    return Platform.isAndroid;
  }

  static bool get isIOS {
    if (kIsWeb) return false;
    return Platform.isIOS;
  }

  static bool get isWeb => kIsWeb;
}
