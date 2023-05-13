import 'dart:io';

import 'package:e_missi_service_provider/export.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  String data;
  bool? isNetwork;
  bool? isPDF;

  PdfView(this.data, {this.isNetwork, this.isPDF});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: isPDF == true ? Colors.white : Colors.black,
          elevation: margin_0,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: AssetImageWidget(
              imageUrl: ic_back_image,
              imageFitType: BoxFit.cover,
              imageHeight: height_5,
              color: isPDF == true ? blackColor : whiteColor,
            ).paddingAll(margin_12),
          ),
        ),
        body: isPDF == true
            ? isNetwork == true
                ? SfPdfViewer.network(data,
                    enableDoubleTapZooming: false,
                    currentSearchTextHighlightColor: Colors.yellow,
                    enableTextSelection: false,
                    canShowPaginationDialog: false,
                    enableDocumentLinkAnnotation: true,
                    onDocumentLoadFailed: (PdfDocumentLoadFailedDetails
                        pdfDocumentLoadFailedDetails) {},
                    scrollDirection: PdfScrollDirection.vertical)
                : SfPdfViewer.file(File(data),
                    enableDoubleTapZooming: false,
                    currentSearchTextHighlightColor: Colors.yellow,
                    enableTextSelection: false,
                    canShowPaginationDialog: false,
                    enableDocumentLinkAnnotation: true,
                    onDocumentLoadFailed: (PdfDocumentLoadFailedDetails
                        pdfDocumentLoadFailedDetails) {},
                    scrollDirection: PdfScrollDirection.vertical)
            : PhotoView(
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                imageProvider: isNetwork == true
                    ? NetworkImage(data)
                    : setFileImage(url: data, radius: margin_0),
              ),
      ),
    );
  }
}

setFileImage(
    {required String url, double? height, double? width, double? radius}) {
  return FileImage(
    File(url),
  );
}
