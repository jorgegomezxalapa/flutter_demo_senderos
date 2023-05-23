import 'package:flutter/material.dart';

class ComponentProgressIndicator extends StatelessWidget {
  final String title;
  const ComponentProgressIndicator({Key? key, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(
              color: Color.fromARGB(250, 35, 91, 78)),
          Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(250, 35, 91, 78),
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ]);
  }
}
