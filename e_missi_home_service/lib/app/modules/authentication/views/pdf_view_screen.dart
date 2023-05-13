import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

import '../../../../export.dart';
import '../controllers/pdfViewController.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfViewController>(
        init: PdfViewController(),
        builder: (controller) {
          return Scaffold(
            body: Container(
              child: controller.document == null
                  ? Container()
                  : PDFViewer(
                      scrollDirection: Axis.vertical,
                      showPicker: false,
                      document: controller.document),
            ),
          );
        });
  }
}
