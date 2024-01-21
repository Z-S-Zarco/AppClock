
import 'package:clock_app/data.dart';
import 'package:clock_app/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;



class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
     child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
         const Text(
             'Alarm',
             style: TextStyle(color: Colors.white, fontSize: 24),
         ),
        Expanded(
          child: ListView(
            children: alarms.map<Widget>((alarm) {
              return Container(
                margin: const EdgeInsets.only(bottom: 32) ,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                decoration: const BoxDecoration(
                  gradient:
                    LinearGradient(colors: [Colors.greenAccent, Colors.pink],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(

                  children: <Widget>[
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: <Widget>[
                        const Row(
                          children: [
                            Icon(
                              Icons.label,
                              color: Colors.white,
                              size: 24,

                            ),
                            SizedBox(width: 20),
                            Text('Office',
                            style: TextStyle(
                              color: Colors.white
                            ),),
                          ],
                        ),

                        Switch(
                            onChanged: (bool value) {},
                            value: true,
                           activeColor: Colors.blue ),
                      ],
                    ),

                     Text(
                      'Mon-Fri',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                          '07:00 AM',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                                             ),
                         Icon(Icons.keyboard_arrow_down,
                         size: 44,
                         color: Colors.white)
                       ],
                     )
                  ],
                ),
              );
            }).followedBy([
              DottedBorder(
                strokeWidth: 3,
                color: Colors.white,
                borderType: BorderType.RRect,
                radius: const Radius.circular(28),
                dashPattern: [3,0],

                child: Container(
                  width: double.infinity,
                
                  decoration:  const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),

                  child: MaterialButton(
                    padding:const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    onPressed: () {
                    scheduleAlarm();
                    },
                    child: Column(
                      children: <Widget>[
                        Image.asset('img/add.png', scale: 0.6,),
                        SizedBox(height: 8),
                        const Text(
                          'Add Alarm',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]).toList(),
          ),
        ),


       ],
     ),
    );
  }


  void scheduleAlarm() async {
    var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 10));


    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Your channel description',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound("a_long_cold_string"),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );


    var iosPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);


    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );


    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Office',
      'Good morning! Time for Coffee',
      tz.TZDateTime.from(
        tz.local as DateTime,
        scheduledNotificationDateTime as tz.Location,
      ),
      const Duration(seconds: 10) as NotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}