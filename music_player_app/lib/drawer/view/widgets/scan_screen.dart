// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../all_songs/view/all_songs.dart';
import '../../../utilities/colors.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isplaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    Future.delayed(
      Duration.zero,
      () {
        _animationController.reset();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 42, 11, 99),
        title: const Text(
          "Scan Music",
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 42, 11, 99),
              Color.fromARGB(235, 48, 14, 34),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 200,
                      color: Colors.amber,
                    ),
                  ),
                  buildRotationTransition(),
                ],
              ),
              Center(
                child: AnimatedTextKit(
                  totalRepeatCount: 30,
                  animatedTexts: [
                    WavyAnimatedText(
                      'Scanning.....',
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Scan'),
                onPressed: () {
                  if (_isplaying) {
                    _animationController.repeat();
                    scanToast().then((value) => _animationController.stop());
                  }
                  setState(() {
                    _isplaying = !_isplaying;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      18.0,
                    ),
                  ),
                  primary: Colors.amber,
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RotationTransition buildRotationTransition() {
    return RotationTransition(
      turns: _animationController,
      child: ClipOval(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 200,
          decoration: BoxDecoration(
            gradient: SweepGradient(
              colors: [
                const Color.fromARGB(255, 66, 64, 64).withOpacity(0.2),
                Colors.white.withOpacity(0.6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> scanToast() async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    if (AllSongs.songs.isEmpty) {
      return showTopSnackBar(
        context,
        CustomSnackBar.error(
          iconPositionLeft: 0,
          iconPositionTop: 0,
          iconRotationAngle: 0,
          icon: Icon(
            Icons.abc,
            color: background2,
          ),
          backgroundColor: background2,
          message: "no Songs found",
        ),
      );
    }
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        iconPositionLeft: 0,
        iconPositionTop: 0,
        iconRotationAngle: 0,
        icon: const Icon(
          Icons.abc,
          color: Colors.amber,
        ),
        backgroundColor: Colors.amber,
        message: "Songs Scanned Total songs:${AllSongs.songs.length} ",
      ),
    );
  }
}
