/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? labelText;
  final String? tvHeading;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final Color? courserColor;
  final validate;
  final hintStyle;
  final EdgeInsets? contentPadding;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? inputAction;
  final bool? hideBorder;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final int? maxline;
  final decoration;
  final int? minLine;
  final int? maxLength;
  final bool readOnly;
  final bool? shadow;
  final bool? obscureText;
  final bool? isOutined;
  final bool? labels;
  final bool? alignLabelWithHint;
  final Function(String value)? onChange;
  final inputFormatter;
  final errorColor;
  final borders;
  final prefixWidth;

  const TextFieldWidget({
    this.hint,
    this.labelText,
    this.tvHeading,
    this.inputType,
    this.textController,
    this.hintStyle,
    this.courserColor,
    this.validate,
    this.onChange,
    this.decoration,
    this.labels,
    this.radius,
    this.focusNode,
    this.readOnly = false,
    this.shadow,
    this.onFieldSubmitted,
    this.inputAction,
    this.prefixWidth,
    this.height,
    this.width,
    this.contentPadding,
    this.isOutined = false,
    this.maxline = 1,
    this.minLine = 1,
    this.maxLength,
    this.color,
    this.hideBorder = true,
    this.alignLabelWithHint = true,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.obscureText,
    this.onTap,
    this.inputFormatter,
    this.errorColor,
    this.borders,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labels == null
            ? Text(labelText?.toUpperCase() ?? hint!.toUpperCase().toString(),
                style:
                    TextStyle(fontSize: font_12, color: Colors.grey.shade400))
            : Container(),
        TextFormField(
            maxLength: maxLength,
            readOnly: readOnly,
            inputFormatters: inputFormatter ??
                [
                  FilteringTextInputFormatter(
                      RegExp(
                          '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                      allow: false),
                ],
            controller: textController,
            focusNode: focusNode,
            keyboardType: inputType,
            textInputAction: inputAction,
            validator: validate,
            onTap: onTap,
            minLines: minLine == null ? 1 : minLine,
            onFieldSubmitted: onFieldSubmitted,
            maxLines: maxline == null ? 1 : maxline,
            cursorColor: buttonColors,
            obscureText: obscureText ?? false,
            onChanged: onChange,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: false,
            decoration: new InputDecoration(
              errorMaxLines: 2,
              counterText: '',
              suffixIcon: suffixIcon ?? null,
              prefixIcon: prefixIcon ?? null,
              prefixIconConstraints:
                  BoxConstraints(maxWidth:prefixWidth?? margin_30, maxHeight: margin_30),
              suffix: suffix ?? null,
              hintText: hint,
              hintStyle: hintStyle ??
                  TextStyle(fontSize: font_12, color: Colors.grey.shade400),
              errorStyle: TextStyle(
                  color: redColor,
                  fontSize: font_12,
                  fontWeight: FontWeight.w500),
              alignLabelWithHint: alignLabelWithHint ?? true,
              labelStyle: textStyleBody2(),
              contentPadding: contentPadding ?? EdgeInsets.zero,
              border: borders ??
                  UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1.5)),
              focusedBorder: borders ??
                  UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1.5)),
              errorBorder: borders ??
                  UnderlineInputBorder(
                      borderSide: BorderSide(color: redColor, width: 1.5)),
              focusedErrorBorder: borders ??
                  UnderlineInputBorder(
                      borderSide: BorderSide(color: redColor, width: 1.5)),
              disabledBorder: borders ??
                  UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1.5)),
              enabledBorder: borders ??
                  UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1.5)),
            )),
      ],
    );
  }
}
