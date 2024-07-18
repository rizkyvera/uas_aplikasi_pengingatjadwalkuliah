import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: MyHomePage());
  }
}

/// The hove page which hosts the calendar
class MyHomePage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
      view: CalendarView.schedule,//bagian ganti model kalender
      dataSource: MeetingDataSource(_getSumberDataAcara()),
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    ));
  }

  List<Meeting> _getSumberDataAcara() {
    final List<Meeting> meetings = <Meeting>[
      Meeting("eventName1", DateTime(2024,6,23), DateTime(2024,6,24), Color.fromARGB(255, 49, 220, 69), true),
      Meeting("eventName1", DateTime(2024,6,24), DateTime(2024,6,24), Color.fromARGB(255, 61, 38, 217), true),
      Meeting("eventName1", DateTime(2024,6,25), DateTime(2024,6,26), const Color.fromARGB(255, 181, 159, 158), true),
      Meeting("eventName1", DateTime(2024,6,26), DateTime(2024,6,27), Colors.green, true),
      Meeting("eventName1", DateTime(2024,6,23), DateTime(2024,6,24), Colors.pink, true),
      Meeting("eventName1", DateTime(2024,6,23), DateTime(2024,6,24), const Color.fromARGB(255, 54, 244, 177), false),
      Meeting("eventName1", DateTime(2024,6,23), DateTime(2024,6,27), Color.fromARGB(255, 161, 53, 223), true),
      Meeting("eventName1", DateTime(2024,6,23), DateTime(2024,6,24), Color.fromARGB(255, 24, 242, 49), true),
    ];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}