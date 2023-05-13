import 'package:e_missi_home_service/export.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class PdfViewController extends GetxController {
  var url;
  var document;
  var id;

  @override
  void onInit() {
    if (Get.arguments != null) {
      url = Get.arguments['url'];
      update();
      debugPrint(url.toString());
    }
    loadDocument(url: url);
    super.onInit();
  }

  loadDocument({url}) async {
    document = await PDFDocument.fromURL(url);
    update();
    debugPrint('Document $url');
    return document;
  }
}
