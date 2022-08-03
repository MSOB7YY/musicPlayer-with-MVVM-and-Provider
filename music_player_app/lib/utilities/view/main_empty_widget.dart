import 'package:flutter/material.dart';

class MainItemEmpty extends StatelessWidget {
  const MainItemEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
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
      child: const Center(
        child: Text(
          "Nothing found!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
