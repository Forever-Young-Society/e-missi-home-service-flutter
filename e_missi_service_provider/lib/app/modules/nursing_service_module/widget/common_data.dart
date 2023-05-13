import 'package:e_missi_service_provider/export.dart';

getContainer(child) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(margin_15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: margin_3,
              blurRadius: margin_3)
        ]),
    child: child,
  );
}

inkWell({child, ontap}) {
  return InkWell(
    child: child,
    onTap: ontap,
  );
}
