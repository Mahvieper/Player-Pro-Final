import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'RoundSliderThumbShape.dart';

class PracticePage extends StatefulWidget {
  final UserModel userModel;
  PracticePage(this.userModel);
  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: const ValueKey<String>('home_page'),
         /* appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),*/
          body: _BumbleBeeRemoteVideo(widget.userModel),
        ),
      ),
    );
  }
}

class _BumbleBeeRemoteVideo extends StatefulWidget {
  final UserModel userModel;
  _BumbleBeeRemoteVideo(this.userModel);
  @override
  _BumbleBeeRemoteVideoState createState() => _BumbleBeeRemoteVideoState();
}

class _BumbleBeeRemoteVideoState extends State<_BumbleBeeRemoteVideo> {
  VideoPlayerController _controller;
  ui.Image customImage;

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void initState() {
    super.initState();
    load('assets/slider_thumb.png').then((image) {
      setState(() {
        customImage = image;
      });
    });

    _controller = VideoPlayerController.network(
      widget.userModel.videoUrl,
    )..initialize().then((_) {
        setState(() {});
      });

    _controller.setLooping(true);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget slider(VideoPlayerController controller) {
      return SliderTheme(
        data: SliderThemeData(
            thumbShape: RoundSliderThumbShapeExtended(customImage),
            trackHeight: 0.5),
        child: Slider(
            value: controller.value.position != null
                ? controller.value.position.inMilliseconds.toDouble()
                : 0,
            activeColor: Color(0xFFbf2431),
            inactiveColor: Color(0xFFbf2431),
            /* position.inSeconds.toDouble(),*/
            min: 0.0,
            //   max: 100,
            max: controller.value.duration != null
                ? controller.value.duration.inMilliseconds.toDouble()
                : 0,
            onChanged: (double newValue) {
              setState(() {
                // onTapPosition = newValue;
                Duration newDuration = Duration(milliseconds: newValue.toInt());
                // _position = newDuration;
                controller.seekTo(newDuration);
              });
            }),
      );
    }

    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // const Text('With remote mp4'),


          Flexible(
            child: Stack(children: [
              _controller.value.initialized
                  ? VideoPlayer(_controller)
                  : Container(),

              Align(alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xaab3a3a3a)
                ),
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back,color: Color.fromRGBO(211, 172, 43, 1),size: MediaQuery.of(context).size.height * 0.04,),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),)
            ],),
          ),

          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(58, 58, 58, 1),
                border: Border(
                    top: BorderSide(
                        color: Color.fromRGBO(211, 172, 43, 1), width: 3))),
            height: MediaQuery.of(context).size.height / 3.5,
            child: Column(
              children: [
                // VideoProgressIndicator(_controller, allowScrubbing: true,colors: VideoProgressColors(playedColor: Color.fromRGBO(184, 38, 49, 1),bufferedColor: Color.fromRGBO(184, 38, 49, 1)),),
                slider(_controller),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: _controller.value.position != null
                          ? Text(
                              _printDuration(Duration(
                                  seconds: _controller.value.position.inSeconds)),
                              style: TextStyle(color: Colors.white),
                            )
                          : Text("0"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: _controller.value.duration != null
                          ? Text(
                              _printDuration(Duration(
                                  seconds: _controller.value.duration.inSeconds)),
                              style: TextStyle(color: Colors.white),
                            )
                          : Text("0"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                _PlayPauseOverlay(controller: _controller),
              ],
            ),
          ),
          //ClosedCaption(text: _controller.value.caption.text),
        ],
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: () {
                Duration duration = controller.value.position;
                duration = duration - Duration(seconds: 15);
                controller.seekTo(duration);
              },
              child: Image.asset(
                "assets/Rewind.png",
                height: 50,
                width: 50,
              )),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 50),
            reverseDuration: Duration(milliseconds: 200),
            child: controller.value.isPlaying
                ? Container(
                    color: Color.fromRGBO(58, 58, 58, 1),
                    child: Center(
                      child: Icon(
                        Icons.pause,
                        color: Color(0xFFbf2431),
                        size: 100.0,
                      ),
                    ),
                  )
                : Container(
                    color: Color.fromRGBO(58, 58, 58, 1),
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Color.fromRGBO(211, 172, 43, 1),
                        size: 100.0,
                      ),
                    ),
                  ),
          ),
          InkWell(
              onTap: () {
                Duration duration = controller.value.position;
                duration = duration + Duration(seconds: 15);
                controller.seekTo(duration);
              },
              child: Image.asset(
                "assets/forward.png",
                height: 50,
                width: 50,
              )),
        ],
      ),
    );
  }
}
