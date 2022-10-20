import 'package:flutter/material.dart';

class HeadingBar extends StatelessWidget {
  const HeadingBar(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(255, 138, 0, 0.8)),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 62,
      child: Row(
        children: [
          const SizedBox(
            width: 65,
          ),
          Container(
            height: 62,
            decoration: const BoxDecoration(color: Colors.white),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}