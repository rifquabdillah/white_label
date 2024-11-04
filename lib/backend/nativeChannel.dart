import 'package:flutter/services.dart';

class NativeChannel {
  // Private constructor
  NativeChannel._privateConstructor();

  // Single instance of NativeChannel
  static final NativeChannel instance = NativeChannel._privateConstructor();

  static const PULSA_PAKET_PLATFORM =
  MethodChannel('com.example.white_label/pulsa_paket_produk_channel');

  void initialize() {
    // Any initialization logic can go here, if needed
    print('NativeChannel initialized');
  }

  Future<Map<String, List<Map<String, dynamic>>>> getPulsaPaketProduk(
      String prefix, String namaMethod) async {
    try {
      // Log the received prefix
      print('Received prefix: $prefix');

      // Invoke the method channel and expect a Map response
      final Map<dynamic, dynamic> result = await PULSA_PAKET_PLATFORM.invokeMethod(
        namaMethod,
        {
          'prefix': prefix,
        },
      );

      // Log the raw returned result
      print('Raw result from native platform: $result');

      // Map the dynamic result to a strongly typed Map<String, List<Map<String, dynamic>>>
      final Map<String, List<Map<String, dynamic>>> mappedResult = result.map((key, value) {
        return MapEntry(
          key as String,
          (value as List).map((item) => Map<String, dynamic>.from(item as Map)).toList(),
        );
      });

      return mappedResult;
    } on PlatformException catch (e) {
      // Log the error message if the method invocation fails
      print('Failed to get data: ${e.message}');
      throw 'Failed to get data: ${e.message}';
    }
  }
}