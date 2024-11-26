
import 'package:flutter/material.dart';


class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Text('Round 1',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),)
      ),
    );
  }
}




class CurrentGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Game'),
      ),
      body: Align(
        alignment: Alignment.topCenter, 
        child: Text('',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),)
      ),
    );
  }
}