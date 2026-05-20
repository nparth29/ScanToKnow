// lib/features/ocr/data/ocr_api_service.dart

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../../../../core/config/app_config.dart';

class OCRApiService {
  static String get _baseUrl => '${AppConfig.baseUrl}/v1/ocr/scan';

  /// Upload image using File (legacy support)
  static Future<Map<String, dynamic>> scanImage(File image) async {
    final request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
    request.files.add(
      await http.MultipartFile.fromPath('image', image.path),
    );
    return _send(request);
  }

  /// Upload preprocessed image using bytes (used by scanner pipeline)
  static Future<Map<String, dynamic>> scanImageBytes(Uint8List bytes) async {
    final request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
    request.files.add(
      http.MultipartFile.fromBytes('image', bytes, filename: 'scan.jpg'),
    );
    return _send(request);
  }

  static Future<Map<String, dynamic>> _send(
      http.MultipartRequest request) async {
    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception('OCR request failed: ${response.statusCode}');
    }

    final decoded = jsonDecode(body);
    if (decoded['data'] == null) throw Exception('Empty OCR response');
    return decoded['data'];
  }
}