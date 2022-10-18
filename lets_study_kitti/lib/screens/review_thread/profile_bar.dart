import 'package:flutter/material.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar(this.name, this.major, {Key? key}) : super(key: key);
  final String name, major;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width * 0.7,
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/user.png')),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Text(
            "($major)",
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
