import 'dart:async';

import 'package:clock_app/clock_view.dart';
import 'package:clock_app/data.dart';
import 'package:clock_app/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'alarmpage.dart';
import 'menuinfo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var now = DateTime.now();
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  var formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());
  var timeZoneString = DateTime.now().timeZoneOffset.toString().split('.').first;
  var offSetSign = '';

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
        formattedTime = DateFormat('HH:mm').format(now);
        formattedDate = DateFormat('EEE, d MMM').format(now);
      });
    });

    if (!timeZoneString.startsWith('-')) {
      offSetSign = '+';
    }
    print(timeZoneString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D4B72),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((currentMenuInfo) => buildMenuButton(currentMenuInfo)).toList(),
          ),
          Container(
            color: Colors.white,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {
                if(value.menuType == MenuType.alarm) {
                  return AlarmPage();
                } else if(value.menuType != MenuType.clock) {
                  return Container();
                }
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Clock',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      formattedTime,
                      style: const TextStyle(color: Colors.white, fontSize: 64),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    ClockView(),
                    const Text(
                      'Timezone',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'UTC$offSetSign$timeZoneString',
                          style: const TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              );

              },

            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false );
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentMenuInfo.imageSource, scale: 0.7,),
              const SizedBox(height: 16),
              Text(
                currentMenuInfo.title ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        );
      },

    );
  }
}
