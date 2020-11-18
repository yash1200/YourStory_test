import 'package:flutter/material.dart';
import 'package:intern_test/ui/demo.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Page 1 Screen'),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Demo();
                },
              ));
            },
            child: Text('Navigate'),
          ),
        ],
      ),
    );
  }
}
