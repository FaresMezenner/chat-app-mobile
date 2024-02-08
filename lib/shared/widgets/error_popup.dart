import 'package:flutter/material.dart';

class ErrorPopup extends StatelessWidget {
  final List<TextButton> buttons;
  final String title, message;
  const ErrorPopup(
      {super.key,
      this.buttons = const [],
      required this.title,
      required this.message});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.5;
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        width: width,
        height: height,
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: buttons,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
