import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:krzv2/services/picker_service.dart';

class FileImagePickerActionSheetView extends GetView {
  const FileImagePickerActionSheetView({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final Function(File) onSelected;
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text('اختر نوع المرفق'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            final result = await PickerService.pickFiles();

            if (result != null) {
              final filePath = result.files.single.path;
              final file = File(filePath!);
              onSelected(file);
            }
          },
          child: Text('ملف'),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context);
            final result = await PickerService.pickImage();
            if (result != null) {
              final File file = File(result.path);

              onSelected(file);
            }
          },
          child: Text('صورة'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('رجوع'),
        ),
      ],
    );
  }
}
