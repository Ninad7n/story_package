import 'dart:async';

import 'package:flutter/material.dart';

class LinearTimer extends StatefulWidget {
  final int durationMiliseconds;
  final double? progressBarHeight;
  final Function onTimerFinish;

  const LinearTimer({
    super.key,
    required this.durationMiliseconds,
    required this.onTimerFinish,
    this.progressBarHeight,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LinearTimerState createState() => _LinearTimerState();
}

class _LinearTimerState extends State<LinearTimer> {
  late int _milisecondsRemaining;
  late double _barWidth;
  int durationMiliseconds = 17;
  // Timer? timer;

  @override
  void initState() {
    super.initState();
    // Get.find<StoriesController>().durationPauseStream = StreamController<void>();
    _milisecondsRemaining = 0;
    _barWidth = 1.0;
    startTimer();
  }

  @override
  void dispose() {
    // Get.find<StoriesController>().durationPauseStream.close();
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(Duration(milliseconds: durationMiliseconds), (timer) {
      if (mounted) {
        setState(() {
          if (_milisecondsRemaining < widget.durationMiliseconds) {
            _milisecondsRemaining += durationMiliseconds;
            _barWidth = _milisecondsRemaining / widget.durationMiliseconds;
          } else {
            widget.onTimerFinish();
            timer.cancel();
          }
        });
      }
    });
  }

  // pauseTimer() {
  //   timer!.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        height: widget.progressBarHeight ?? 3.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white60,
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: _barWidth,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
          ),
        ),
      ),

      /* StreamBuilder(
          stream: Get.find<StoriesController>().durationPauseStream.stream,
          builder: (context, snap) {
            log("${snap.data}", name: "timer");
            if(snap.data != null && (snap.data as bool)) {
              log("${snap.data}", name: "timer--------------");
              if(timer != null) {
                log("${snap.data}", name: "timer89898988989");
                pauseTimer();
              }
            }else {
              if(!timer!.isActive){
                startTimer();
              }
            }
          return Container(
            height: 3.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white60,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _barWidth,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      ), */
    );
  }
}
