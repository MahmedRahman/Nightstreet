import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krzv2/component/views/custom_dialogs.dart';

class PickerService {
  static Future<XFile?> pickImage({
    double? maxWidth = 100,
    double? maxHeight = 100,
    int? quality = 50,
  }) async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedFile;
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );

      pickedFile = file;
    } on PlatformException catch (e) {
      AppDialogs.showToast(message: e.message!);
    } catch (e) {
      print('error getImage => $e');
    }

    return pickedFile;
  }

  static Future<FilePickerResult?> pickFiles() async {
    FilePickerResult? pickedFile;
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['pdf', 'doc'],
        type: FileType.custom,
      );

      pickedFile = result;
    } on PlatformException catch (e) {
      AppDialogs.showToast(message: e.message!);
    } catch (e) {
      log('Unsupported operation' + e.toString());
    }

    return pickedFile;
  }
}
