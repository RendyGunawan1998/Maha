import 'dart:io';
import '../../core.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        return File(photo.path);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
    return null;
  }
}
