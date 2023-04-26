import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'Home',
          style: TextStyle(
              fontSize: 28,
              color: Colors.black),
        ),
      ),
    );
  }
}


