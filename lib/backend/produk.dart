import 'package:white_label/backend/nativeChannel.dart';


class Produk {

  Future<Map<String, List<Map<String, dynamic>>>> fetchProduk(
      String? prefix,
      String tipeProduk,
      String? catatan
  ) async {
    var result = await NativeChannel.instance.getProduk(
      prefix,
      tipeProduk,
      catatan,
    );

    return result;
  }

  Future<Map<String, dynamic>> fetchTagihan(
      String kodeProduk,
      String data,
      ) async {
    var result = await NativeChannel.instance.getTagihan(
      kodeProduk,
      data,
    );aa

    return result;
  }
}