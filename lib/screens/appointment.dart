import 'package:flutter/material.dart';
import 'package:rappelle_moi/palette.dart';
import 'package:rappelle_moi/widgets/widgets.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  List<String> widgetList = ['A', 'B', 'C','D', 'E', 'F','G', 'H', 'I'];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(),
        Container(
          height: size.height,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 1,
            childAspectRatio: 2.5,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.only(right: 20, left: 20, top: 60),
            children: widgetList.map((String value) {
              return new GridTile(
                  header: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)
                      ),
                      color: Colors.blue.withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Service :", style: kBodySmallText),
                    ),
                  ),
                  footer: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.grey.withOpacity(0.7),
                    child: new Text('Nom médecin', style: kBodySmallText,),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)
                      ),
                      border: Border.all(
                          color: Colors.grey
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.date_range, color: Colors.white),
                        Icon(Icons.access_time, color: Colors.white,),
                      ],
                    ),
                  )
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
