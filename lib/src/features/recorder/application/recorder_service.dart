import 'dart:io';

import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'recorder_service.g.dart';

class RecorderService {
  final recorder = AudioRecorder();

  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tempRecording.m4a');
  }

  Future<bool> startRecording() async {
    if (await recorder.hasPermission()) {
      // Start recording to file
      final savePath = await _localFile;
      await recorder.start(const RecordConfig(numChannels: 1),
          path: savePath.path);
      // // ... or to stream
      // final stream = await recorder
      //     .startStream(const RecordConfig(encoder: AudioEncoder.aacHe));
      return true;
    }
    return false;
  }

  Future<String> stopRecording() async {
    try {
      final path = await recorder.stop();
      // recorder.dispose();
      return path ?? '';
    } catch (e) {
      // print(e.toString());
      return '';
    }
  }

  void cancelRecording() async {
    await recorder.cancel();
    // recorder.dispose();
  }
}

@Riverpod(keepAlive: true)
RecorderService recorderService(RecorderServiceRef ref) => RecorderService();
