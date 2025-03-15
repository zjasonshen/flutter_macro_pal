import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:macro_ai/src/features/backend/application/backend_service.dart';
import 'package:macro_ai/src/features/recorder/application/recorder_service.dart';
import 'package:macro_ai/src/features/tracker/data/image_input_file_provider.dart';
import 'package:macro_ai/src/features/tracker/data/transcribed_text_provider.dart';

class InputBox extends ConsumerStatefulWidget {
  const InputBox({super.key});

  @override
  InputBoxState createState() => InputBoxState();
}

class InputBoxState extends ConsumerState<InputBox> {
  late TextEditingController _textController;
  bool _isRecording = false;
  Timer? _recordingTimer;
  int _recordingDuration = 0;
  final picker = ImagePicker();

  void _onCameraPressed() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (pickedFile != null) {
      ref.read(imageInputFileProvider.notifier).updateImage(pickedFile);
    }
  }

  void _onMicrophonePressed() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      _startRecording();
    } else {
      _stopRecording();
    }
  }

  void _startRecording() {
    HapticFeedback.mediumImpact();
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration++;
      });
    });
    ref.read(recorderServiceProvider).startRecording();
  }

  void _stopRecording() {
    HapticFeedback.mediumImpact();
    _recordingTimer?.cancel();
    setState(() {
      _recordingDuration = 0;
    });
    final filePathFuture = ref.read(recorderServiceProvider).stopRecording();
    filePathFuture.asStream().listen((filePath) {
      setState(() {
        _isRecording = false;
      });
      final service =
          ref.read(backendServiceProvider).uploadAudio(File(filePath));
      service.asStream().listen((response) {
        ref.read(transcribedTextProvider.notifier).updateText(response);
      });
    });
  }

  void _updateProvider() {
    ref.read(transcribedTextProvider.notifier).updateText(_textController.text);
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.addListener(_updateProvider);
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _textController.removeListener(_updateProvider);
    _textController.dispose();
    super.dispose();
  }

  Widget sendOrRecordButton(String textInput, bool canSubmit) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    if (textInput.isEmpty) {
      return IconButton(
        onPressed: _onMicrophonePressed,
        icon: Icon(
          _isRecording ? Icons.stop : Icons.mic,
          color: _isRecording ? colorScheme.error : colorScheme.primary,
        ),
      );
    } else {
      final isSubmitting = ref.watch(isSubmittingProvider);

      return IconButton(
        onPressed: canSubmit && !isSubmitting
            ? () async {
                ref.read(isSubmittingProvider.notifier).state = true;
                try {
                  await ref.read(backendServiceProvider).submitInput();
                } finally {
                  ref.read(isSubmittingProvider.notifier).state = false;
                }
              }
            : null,
        icon: isSubmitting
            ? const CircularProgressIndicator()
            : Icon(
                Icons.arrow_upward,
                color: canSubmit ? colorScheme.primary : colorScheme.onSurface,
              ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imageInputFileProvider);
    final textInput = ref.watch(transcribedTextProvider);
    final canSubmit = image != null || textInput.isNotEmpty;
    ref.listen<String>(transcribedTextProvider, (previous, next) {
      if (_textController.text != next) {
        _textController.text = next;
      }
    });
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey),
          //   borderRadius: BorderRadius.circular(50),
          // ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                if (image != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(image.path),
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: () {
                              ref
                                  .read(imageInputFileProvider.notifier)
                                  .clearImage();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (_isRecording)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mic, color: colorScheme.onError),
                        const SizedBox(width: 8),
                        Text(
                          'Recording ${_recordingDuration}s',
                          style: TextStyle(color: colorScheme.onError),
                        ),
                      ],
                    ),
                  ),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter meal description.',
                    prefixIcon: IconButton(
                      onPressed: _onCameraPressed,
                      icon: Icon(Icons.camera_alt, color: colorScheme.primary),
                    ),
                    suffixIcon: sendOrRecordButton(textInput, canSubmit),
                  ),
                  maxLines: 2,
                  minLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final isSubmittingProvider = StateProvider<bool>((ref) => false);
