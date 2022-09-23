import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lentera_ilmu/services/service.dart';

class AssetService {
  Future upload(File file, String location) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://asset.lenterailmu.id/upload'),
      );
      request.headers.addAll({"Authorization": authorizationAssetHeader});
      request.files.add(await http.MultipartFile.fromPath("file", file.path));
      request.fields['location'] = location;
      http.Response response =
          await http.Response.fromStream(await request.send());
      final parsed = jsonDecode(response.body).cast<String, dynamic>();
      // ignore: avoid_print
      print(parsed["data"]);
      return parsed["data"];
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return <String, dynamic>{
        "error_message": "Tidak dapat mengakses layanan."
      };
    }
  }
}
