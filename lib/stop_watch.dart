import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  late Stopwatch stopwatch;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  void startStopWatch() {
    setState(() {
      stopwatch.start();
    });
  }

  void stopStopWatch() {
    setState(() {
      stopwatch.stop();
    });
  }

  void resetStopWatch() {
    setState(() {
      stopwatch.reset();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formattedTime() {
    final int milliseconds = stopwatch.elapsedMilliseconds;
    final int seconds = (milliseconds / 1000).truncate();
    final int minutes = (seconds / 60).truncate();
    final int hours = (minutes / 60).truncate();

    final String formattedMilliseconds =
        (milliseconds % 1000).toString().padLeft(3, '0');
    final String formattedSeconds = (seconds % 60).toString().padLeft(2, '0');
    final String formattedMinutes = (minutes % 60).toString().padLeft(2, '0');
    final String formattedHours = hours.toString().padLeft(2, '0');

    return "$formattedHours:$formattedMinutes:$formattedSeconds.$formattedMilliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 85, 60),
      appBar: AppBar(
          shape: const BorderDirectional(
              bottom: BorderSide(color: Colors.amber, width: 3)),
          backgroundColor: const Color.fromARGB(255, 44, 85, 60),
          title: const Padding(
            padding: EdgeInsets.only(left: 10.0, top: 20),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "StopWatch",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                Text(
                  formattedTime(),
                  style: TextStyle(
                    fontSize: 50.0,
                    color: stopwatch.isRunning
                        ? Colors.white
                        : const Color.fromARGB(255, 255, 158, 120),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.amber,
                          disabledBackgroundColor:
                              const Color.fromARGB(255, 255, 158, 120),
                          disabledForegroundColor: Colors.black54),
                      onPressed: stopwatch.isRunning ? null : startStopWatch,
                      icon: const Icon(Icons.play_arrow, size: 35)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.amber,
                          disabledBackgroundColor:
                              const Color.fromARGB(255, 255, 158, 120),
                          disabledForegroundColor: Colors.black54),
                      onPressed: stopwatch.isRunning ? stopStopWatch : null,
                      icon: const Icon(Icons.stop, size: 35)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    highlightColor: const Color.fromARGB(255, 255, 224, 120),
                    style: IconButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: resetStopWatch,
                    icon: const Icon(
                      Icons.replay,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
