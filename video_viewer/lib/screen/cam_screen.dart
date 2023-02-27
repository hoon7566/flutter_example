import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../const/agora.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? _engine;

  // 내 아이디
  int _remoteUid = 0;

  int? _otherUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cam Screen'),
      ),
      body: FutureBuilder<bool>(
          future: init(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Stack(
                  children: [
                    renderMainView(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.grey[100],
                        height: 160,
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: renderSubView(),
                        ),
                      ),
                    )

                  ],
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_engine != null) {
                          await _engine!.leaveChannel();
                          _engine = null;
                        }
                      },
                      child: Text("채널 나가기")),
                )
              ],
            );
          }),
    );
  }

  renderSubView() {
    if (_otherUid == null) {
      return Center(child: Text("채널에 아무도 없음"));
    } else {
      return AgoraVideoView(
          controller: VideoViewController.remote(
              rtcEngine: _engine!,
              canvas: VideoCanvas(uid: _otherUid),
              connection: RtcConnection(channelId: CHANNEL_NAME)));
    }
  }

  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final camera = resp[Permission.camera];
    final microphone = resp[Permission.microphone];

    if (camera != PermissionStatus.granted ||
        microphone != PermissionStatus.granted) {
      throw Exception('Camera and microphone permissions are required');
    }

    if (_engine == null) {
      _engine = await createAgoraRtcEngine();

      await _engine!.initialize(RtcEngineContext(
        appId: APP_ID,
      ));

      _engine!.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("채널에 입장했습니다. : uid: ${connection.localUid}");
          setState(() {
            _remoteUid = connection.localUid!;
          });
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          print("채널에서 나갔습니다.");
          setState(() {
            _remoteUid = 0;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print("다른 사람이 입장했습니다. : uid: $remoteUid");
          setState(() {
            _otherUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          print("다른 사람이 나갔습니다. : uid: $remoteUid, reason: $reason");
          setState(() {
            _otherUid = null;
          });
        },
      ));

      await _engine!.enableVideo();
      await _engine!.startPreview();

      ChannelMediaOptions options = ChannelMediaOptions();

      await _engine!.joinChannel(
          token: TEMP_TOKEN,
          channelId: CHANNEL_NAME,
          uid: _remoteUid,
          options: options);
    }

    return true;
  }

  renderMainView() {
    if (_remoteUid == 0) {
      return Center(
        child: Container(
          child: Text('채널에 참여해주세요'),
        ),
      );
    } else {
      return AgoraVideoView(
          controller: VideoViewController(
        rtcEngine: _engine!,
        canvas: VideoCanvas(
          uid: 0,
        ),
      ));
    }
  }
}
