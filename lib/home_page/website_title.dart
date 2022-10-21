import 'package:flutter/material.dart';

class WebsiteTitle extends StatelessWidget {
  const WebsiteTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 130,
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   border: Border.all(),
      // color: Colors.black

      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/smile.png', height: 40, width: 40),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Let\'s Study Kitti',
              style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/images/frown.png', height: 40, width: 40),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Center(
            child: Text(
          'Unimelb\'s Leading Subject Review Website',
          style: TextStyle(fontSize: 30),
        ))
      ]),
    );
  }
}
