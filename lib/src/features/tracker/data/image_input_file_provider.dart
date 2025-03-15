import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'image_input_file_provider.g.dart';

@riverpod
class ImageInputFile extends _$ImageInputFile {
  @override
  XFile? build() {
    return null;
  }

  void updateImage(XFile image) {
    state = image;
  }

  void clearImage() {
    state = null;
  }
}
