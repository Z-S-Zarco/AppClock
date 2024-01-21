import 'package:flutter/material.dart';

import 'enums.dart';
import 'menuinfo.dart';
import 'models/alarminfo.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title:'Clock', imageSource: 'img/clock.png'),
  MenuInfo(MenuType.alarm, title:'Alarm', imageSource: 'img/bell.png'),
  MenuInfo(MenuType.timer, title:'Timer', imageSource: 'img/timer.png'),
  MenuInfo(MenuType.stopwatch, title: 'Stopwatch', imageSource: 'img/stopwatch.png'),
];


List<AlarmInfo> alarms = [
  AlarmInfo(
    DateTime.now().add(const Duration(hours: 1)),
    "Office",
     [Colors.blue, Colors.green],
  ),
  AlarmInfo(
    DateTime.now().add(const Duration(hours: 2)),
    "Sport",
     [Colors.orange, Colors.red],
  ),
];


