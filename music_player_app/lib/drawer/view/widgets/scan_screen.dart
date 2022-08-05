// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/drawer/view_model/scan_function.dart';
import 'package:music_player_app/drawer/view_model/scan_provider.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<ScanProvider>().animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    Future.delayed(
      Duration.zero,
      () {
        context.read<ScanProvider>().animationController.reset();
      },
    );
  }

  @override
  void dispose() {
    context.read<ScanProvider>().animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary0,
        title: const Text(
          "Scan Music",
        ),
        elevation: 0,
      ),
      body: BodyContainer(
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
                      color: kAmber,
                    ),
                  ),
                  context.read<ScanProvider>().buildRotationTransition(context),
                ],
              ),
              Center(
                child: AnimatedTextKit(
                  totalRepeatCount: 30,
                  animatedTexts: [
                    WavyAnimatedText(
                      'Scanning.....',
                      textStyle: TextStyle(
                        color: kWhite,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<ScanFunctionProvider>()
                        .isPlayinFunction(context);
                    context.read<ScanProvider>().isplaying = true;
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
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: context.read<ScanProvider>().isplaying == true
                          ? AnimatedTextKit(
                              totalRepeatCount: 30,
                              animatedTexts: [
                                WavyAnimatedText(
                                  'Scanning.....',
                                  textStyle: TextStyle(
                                    color: kWhite,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Text('scan'))),
            ],
          ),
        ),
      ),
    );
  }
}
