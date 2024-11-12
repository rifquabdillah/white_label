import 'package:flutter/services.dart';

class NativeChannel {
  // Private constructor
  NativeChannel._privateConstructor();

  // Single instance of NativeChannel
  static final NativeChannel instance = NativeChannel._privateConstructor();

  static const PULSA_PAKET_PLATFORM = MethodChannel('com.example.whitelabel/pulsa_paket_produk_channel');
  static const UTILS_CHANNEL = MethodChannel('com.example.whitelabel/utils');
  static const PRODUK_PLATFORM = MethodChannel('com.example.whitelabel/produk');

  // Initialize NativeChannel and set up method call handler
  void initialize() {
    print('NativeChannel initialized');
    UTILS_CHANNEL.setMethodCallHandler(_handleMethodCall);
  }

  /// Check permissions on the native side
  Future<bool> checkPermission() async {
    try {
      final bool isGranted = await UTILS_CHANNEL.invokeMethod('checkPermission');
      return isGranted;
    } on PlatformException catch (e) {
      print('Failed to check permission: ${e.message}');
      return false;
    }
  }

  /// Request image from the gallery if permissions are granted
  Future<String?> pickImageFromGallery() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      try {
        final String? imagePath = await UTILS_CHANNEL.invokeMethod('pickImageFromGallery');
        print('Image path from native: $imagePath');
        return imagePath;
      } on PlatformException catch (e) {
        print('Failed to pick image: ${e.message}');
        return null;
      }
    } else {
      print('Permissions not granted');
      return null;
    }
  }

  Future<Map<String, List<Map<String, dynamic>>>> getProduk(
      String? prefix, String tipeProduk, String? catatan) async {
    try {
      final Map<dynamic, dynamic> result = await PRODUK_PLATFORM.invokeMethod(
        'fetchProduk',
        {
          'prefix': prefix,
          'tipe': tipeProduk,
          'catatan': catatan
        },
      );

      final Map<String, List<Map<String, dynamic>>> mappedResult = result.map((
          key, value) {
        return MapEntry(
          key as String,
          (value as List)
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList(),
        );
      });

      return mappedResult;
    } on PlatformException catch (e) {
      print('Failed to get data: ${e.message}');
      throw 'Failed to get data: ${e.message}';
    }
  }


  Future<Map<String, List<Map<String, dynamic>>>> getPulsaPaketProduk(
      String prefix, String namaMethod) async {
    try {
      print('Received prefix: $prefix');

      final Map<dynamic, dynamic> result = await PULSA_PAKET_PLATFORM.invokeMethod(
        namaMethod,
        {
          'prefix': prefix,
        },
      );

      print('Raw result from native platform: $result');

      final Map<String, List<Map<String, dynamic>>> mappedResult = result.map((key, value) {
        return MapEntry(
          key as String,
          (value as List).map((item) => Map<String, dynamic>.from(item as Map)).toList(),
        );
      });

      return mappedResult;
    } on PlatformException catch (e) {
      print('Failed to get data: ${e.message}');
      throw 'Failed to get data: ${e.message}';
    }
  }

  // New function to open contact picker and get the contact number
  void setPhoneNumberCallback(Function(String) callback) {
    _phoneNumberCallback = callback;
  }

  void setSpeechRecognitionCallback(Function(String) callback) {
    _speechRecognitionCallback = callback;
  }

  Function(String)? _speechRecognitionCallback;
  Function(String)? _phoneNumberCallback; // To hold the callback

  Future<void> getContact() async {
    try {
      await UTILS_CHANNEL.invokeMethod('getContact');
    } on PlatformException catch (e) {
      print('Failed to pick contact: ${e.message}');
    }
  }

  // Method call handler to receive data from the native side
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'contactPicked':
        final String? phoneNumber = call.arguments as String?;
        print('Phone number received from native: $phoneNumber');
        // Clean the phone number
        if (phoneNumber != null) {
          String cleanedNumber = _cleanPhoneNumber(phoneNumber);
          print('Cleaned phone number: $cleanedNumber');
          // Call the callback function to update the phone number
          if (_phoneNumberCallback != null) {
            _phoneNumberCallback!(cleanedNumber); // Update the phone number in Flutter
          }
        }
        break;
      default:
        print('Method not implemented: ${call.method}');
    }
  }

  // Function to clean the phone number
  String _cleanPhoneNumber(String phoneNumber) {
    // Replace +62 with 0
    String cleanedNumber = phoneNumber.replaceAll('+62', '0');
    // Remove all non-numeric characters
    cleanedNumber = cleanedNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return cleanedNumber;
  }

  Future<dynamic> startSpeechRecognition() async {
    try {
      final String? recognizedText = await UTILS_CHANNEL.invokeMethod('startSpeechRecognition');
      print('Recognized text from native: $recognizedText');
      if (_speechRecognitionCallback != null) {
        _speechRecognitionCallback!(recognizedText!);
      }
      return recognizedText;
    } on PlatformException catch (e) {
      print('Failed to recognize speech: ${e.message}');
      return null;
    }
  }
}
