import 'package:get/get.dart';
import 'package:lentera_ilmu/models/media/article.dart';
import 'package:lentera_ilmu/services/media.dart';
import 'package:lentera_ilmu/services/utils.dart';

class MediaController extends GetxController {
  final mediaService = MediaService();
  late List<ArticleModel> articles = <ArticleModel>[].obs;
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getListArticle(0, 5, true);
  }

  Future getMedia() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      var media = await mediaService.getMedia();
      // ignore: avoid_print
      print(media);
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  Future getListArticle(int page, int size, bool restartData) async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      articles =
          await mediaService.getListArticle(page: page, size: size, type: "");
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }
}
