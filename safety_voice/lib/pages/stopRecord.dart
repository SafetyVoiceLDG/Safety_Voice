import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class StopRecord extends StatefulWidget {
  const StopRecord({super.key});

  @override
  State<StopRecord> createState() => _StopRecordState();
}

class _StopRecordState extends State<StopRecord> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isRecorderInitialized = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    try {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
      await _recorder.openRecorder();
      _isRecorderInitialized = true;
    } catch (e) {
      print('🚨 Error initializing recorder: $e');
    }
  }

  Future<void> _startRecording() async {
  try {
    if (!_isRecorderInitialized) throw Exception('Recorder is not initialized');
    final dir = await getApplicationDocumentsDirectory();
    _filePath = '${dir.path}/${DateFormat('yyyyMMddHHmm').format(DateTime.now())}.aac'; // ✅ AAC 형식으로 변경

    await _recorder.startRecorder(
      toFile: _filePath,
      codec: Codec.aacADTS, // ✅ MP3 대신 AAC 사용
    );

    print("🎤 녹음 시작됨: $_filePath");
    setState(() => _isRecording = true);
  } catch (e) {
    print('🚨 Error starting recording: $e');
  }
}


  Future<void> _stopRecording() async {
    try {
      await _recorder.stopRecorder();
      setState(() => _isRecording = false);

      if (_filePath != null) {
        await _saveRecordingPath(_filePath!); // ✅ 녹음 파일 경로 저장
      }
    } catch (e) {
      print('🚨 Error stopping recording: $e');
    }
  }

  // ✅ 녹음된 파일의 경로를 내부 저장소에 기록
  Future<void> _saveRecordingPath(String filePath) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final recordingListFile = File('${dir.path}/recording_list.txt');

      await recordingListFile.writeAsString('$filePath\n', mode: FileMode.append);
      print("✅ 녹음 파일 저장됨: $filePath");
    } catch (e) {
      print("🚨 녹음 파일 저장 오류: $e");
    }
  }

  @override
  void dispose() {
    if (_recorder.isRecording) {
      _recorder.stopRecorder();
    }
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _isRecording ? 220 : 200,
                  height: _isRecording ? 220 : 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isRecording ? Colors.red.withOpacity(0.8) : Colors.grey.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Icon(
                      _isRecording ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/listhome'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        '뒤로가기',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _isRecording ? _stopRecording : _startRecording,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        backgroundColor: _isRecording ? Colors.red : Colors.green,
                      ),
                      child: Text(
                        _isRecording ? 'Stop Recording' : 'Start Recording',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}