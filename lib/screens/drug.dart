import 'package:flutter/material.dart';
import 'package:rappelle_moi/screens/localNotifyManager.dart';

class Drug extends StatefulWidget {
  @override
  _DrugState createState() => _DrugState();
}

class _DrugState extends State<Drug> {

  @override
  void initState() {
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification){
    print('Notification Received : ${notification.id}');
  }

  onNotificationClick(String payload){
    print('Payload $payload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () async{
            //await localNotifyManager.showNotification();
            //await localNotifyManager.scheduleNotification();
           // await localNotifyManager.repeatNotification();
            await localNotifyManager.showDialyAtTimeNotification();
          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }
}
