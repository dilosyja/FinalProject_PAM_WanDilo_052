import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(MaterialApp(
    home: TimeInfo(),
  ));
}

class TimeInfo extends StatefulWidget {
  @override
  _TimeInfoState createState() => _TimeInfoState();
}

class _TimeInfoState extends State<TimeInfo> {
  DateTime _currentTime = DateTime.now();
  String _selectedZone = 'WIB';

  @override
  void initState() {
    super.initState();
    tzdata.initializeTimeZones();
    // Update time every second
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now();
    });
    Future.delayed(Duration(seconds: 1), () => _updateTime());
  }

  String _formatTime(DateTime time, String timeZone) {
    tz.Location location = tz.getLocation(timeZone);
    tz.TZDateTime tzDateTime = tz.TZDateTime.from(time, location);
    return DateFormat.Hms().format(tzDateTime);
  }

  String _convertToZone(String zone) {
    switch (zone) {
      case 'WIB':
        return _formatTime(_currentTime, 'Asia/Jakarta');
      case 'WITA':
        return _formatTime(_currentTime, 'Asia/Makassar');
      case 'WIT':
        return _formatTime(_currentTime, 'Asia/Jayapura');
      default:
        return _formatTime(_currentTime, 'UTC');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "What's",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Marhey'
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Time!",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontFamily: 'Marhey'
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.yellowAccent, Colors.yellow.withOpacity(1)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: kToolbarHeight), // Padding dari app bar
            Align(
              alignment: Alignment.center,
              child: Text(
                'Knows The Time',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Around You!',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
            SizedBox(height: 60.0,),
            Hero(
              tag: 'timeTag',
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  'GMT:\n${_formatTime(_currentTime, 'UTC')}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    fontFamily: 'Digi',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: DropdownButton<String>(
                value: _selectedZone,
                items: ['WIB', 'WITA', 'WIT']
                    .map((zone) => DropdownMenuItem(
                  value: zone,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      zone,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedZone = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Hero(
              tag: 'zoneTag',
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(20),
                child: Text(
                  '$_selectedZone: \n${_convertToZone(_selectedZone)}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    fontFamily: 'Digi',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
