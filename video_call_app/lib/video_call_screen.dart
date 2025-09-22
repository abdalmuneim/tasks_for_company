import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

const String APP_ID = "443640e6c81244f89f7868fdc7158b30";

class VideoCallScreen extends StatefulWidget {
  final String channelName;
  final String callerName;

  const VideoCallScreen({
    super.key,
    required this.channelName,
    required this.callerName,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: APP_ID));
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.joinChannel(
      token:
          "007eJxTYDhhZ6uzaXes5pQWjUlqIX8LPq0UcAxKTDfr4z+1W1L/5TMFBhMTYzMTg1SzZAtDIxOTNAvLNHMLM4u0lGRzQ1OLJGODqQW6GQ2BjAwPQ4sZGKEQxGdhKEktLmFgAADEeB2X", // You should provide a secure token in production
      channelId: widget.channelName,
      uid: 0,
      options: ChannelMediaOptions(),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          print('Joined channel ${widget.channelName}');
        },
      ),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Call with ${widget.callerName}")),
      body: AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: 0),
        ),
      ),
    );
  }
}
