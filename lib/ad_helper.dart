import 'dart:io';

class AdHelper {
static String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    return "ca-app-pub-3181461073325424/2085257806"; // Replace with your real ID
  } else if (Platform.isIOS) {
    return "";
  } else {
    throw UnsupportedError("Unsupported platform");
  }
}
}