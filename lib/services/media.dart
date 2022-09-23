import 'package:lentera_ilmu/models/media/article.dart';
import 'package:lentera_ilmu/models/media/media.dart';
import 'package:lentera_ilmu/services/service.dart';

class MediaService extends ServiceAPI {
  Future<MediaModel> getMedia() async {
    try {
      final result = await get(baseUrlMedia);
      // ignore: avoid_print
      print(result);
      return MediaModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ArticleModel>> getListArticle({
    required int page,
    required int size,
    required String type,
  }) async {
    try {
      final result = await get(
        "$baseUrlMedia/article/list",
        queryParameters: {
          "pagination": true,
          "page": page,
          "size": size,
          "status": "published",
          "type": type,
        },
      );
      return result['items']
          .map<ArticleModel>((json) => ArticleModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
