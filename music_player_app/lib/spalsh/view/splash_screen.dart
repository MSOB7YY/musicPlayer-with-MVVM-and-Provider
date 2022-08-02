import 'package:flutter/material.dart';
import '../../home/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final _animatonController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 8,
    ),
  );
  @override
  void initState() {
    goHome();
    super.initState();
    _animatonController.forward();
  }

  @override
  void dispose() {
    _animatonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 42, 11, 99),
                Color.fromARGB(235, 49, 15, 42),
              ],
            ),
          ),
        ),
        Center(
          child: Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _animatonController,
              child: Container(
                height: 250,
                width: 170,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/malhaarNew3Logo-modified.png',
                    ),
                  ),
                ),
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: 0.5 * 50 * _animatonController.value,
                  child: child,
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
        ),
        const Align(
          alignment: AlignmentDirectional(
            0.1,
            0.3,
          ),
          child: Text(
            "MalhaaR Music",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> goHome() async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) {
          return const MusicHome();
        },
      ),
    );
  }
}
