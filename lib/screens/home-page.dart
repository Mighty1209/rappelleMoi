import 'package:flutter/material.dart';
import 'package:rappelle_moi/palette.dart';

import 'appointment.dart';
import 'drug.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Widget callPage(int index){
    switch (index){
      case 0 :
        return Appointment();
        break;
      case 1:
        return Drug();
        break;
      case 2:
        return Drug();
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: callPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        currentIndex: _currentIndex,
        onTap: (value){
          setState(() {
            _currentIndex=value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.airplay),
            title: Text('Rendez-vous')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('Médicament')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Paramètres')
          )
        ],
      ),
    );
  }
}