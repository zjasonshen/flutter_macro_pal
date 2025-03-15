import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transcribed_text_provider.g.dart';

@riverpod
class TranscribedText extends _$TranscribedText {
  @override
  String build() {
    return '';
  }

  void updateText(String newText) {
    state = newText;
  }

  void clearText() {
    state = '';
  }
}
