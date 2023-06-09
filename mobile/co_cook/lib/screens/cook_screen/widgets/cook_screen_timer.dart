import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:co_cook/styles/colors.dart';
import 'package:co_cook/styles/text_styles.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CookScreenTimer extends StatefulWidget {
  const CookScreenTimer(
      {required this.key, required this.time, required this.play});
  final int time;
  final bool play;
  final GlobalKey<CookScreenTimerState> key; // 글로벌 키 추가

  @override
  State<CookScreenTimer> createState() => CookScreenTimerState();
}

class CookScreenTimerState extends State<CookScreenTimer> {
  late int _currentSeconds;
  late Timer? _timer;
  bool _isPlay = false;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.time;
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _disposeTimer();
    super.dispose();
  }

  void startTimer() {
    if (!_isPlay) {
      setState(() {
        _isPlay = true;
      });
      _timerFunction();
    } else {
      _cancelTimer();
    }
  }

  void _endTimer() {
    if (_isPlay && mounted) {
      print("타이머 종료");
      _timer?.cancel();
      setState(() {
        _isPlay = false;
        _currentSeconds = widget.time;
      });
    }
  }

  void _disposeTimer() {
    if (_isPlay && mounted) {
      print("타이머 종료");
      _timer?.cancel();
      _isPlay = false;
      _currentSeconds = widget.time;
    }
  }

  void _cancelTimer() {
    if (_isPlay) {
      print("타이머 취소");
      _timer?.cancel();
      setState(() {
        _isPlay = false;
        _currentSeconds = widget.time;
      });
    }
  }

  void _timerFunction() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentSeconds > 0) {
          _currentSeconds--;
        } else {
          _endTimer();
          playAlarm();
        }
      });
    });
  }

  void playAlarm() async {
    await _audioPlayer.play(AssetSource('audios/timer_alert.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ZoomTapAnimation(
        onTap: () => startTimer(),
        end: 0.98,
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Color.fromARGB(199, 61, 168, 51),
            borderRadius: BorderRadius.circular(16.0),
          ),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(children: [
              Positioned(child: LayoutBuilder(builder: (context, constraints) {
                return Container(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width:
                        (constraints.maxWidth / widget.time) * _currentSeconds,
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      // backgroundBlendMode: BlendMode.colorBurn,
                      borderRadius: BorderRadius.circular(14.0),
                      color: Color.fromARGB(255, 61, 168, 51),
                    ),
                  ),
                );
              })),
              Container(
                margin: EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Icon(
                      _isPlay ? Icons.stop : Icons.play_arrow,
                      color: CustomColors.monotoneLight,
                      size: 32,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      alignment: Alignment.center,
                      child: Text(
                          "${(_currentSeconds / 60).floor().toString().padLeft(2, "0")}:${(_currentSeconds % 60).toString().padLeft(2, "0")}",
                          style: const CustomTextStyles().subtitle1.copyWith(
                                color: CustomColors.monotoneLight,
                              )),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
