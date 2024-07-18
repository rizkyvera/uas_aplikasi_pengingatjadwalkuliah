import 'package:flutter/material.dart';
import 'jadwal.dart';
import 'deadline_tugas.dart';
import 'ujian.dart'; // Import halaman ujian.dart
import 'kegiatan_akademis.dart'; // Import halaman kegiatan akademis
import 'kalender.dart'; // Import halaman kalender.dart

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Colors.indigo[900], // Background color: dark blue
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.indigo[900], // Background color: dark blue
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildMenuButton(
                  context,
                  title: 'Jadwal',
                  icon: Icons.calendar_today,
                  color: Colors.blue[700]!,
                  page: JadwalPage(),
                ),
                _buildMenuButton(
                  context,
                  title: 'Deadline Tugas',
                  icon: Icons.assignment_turned_in,
                  color: Colors.blue[700]!,
                  page: DeadlineTugasPage(),
                ),
                _buildMenuButton(
                  context,
                  title: 'Ujian',
                  icon: Icons.event_note,
                  color: Colors.blue[700]!,
                  page: UjianPage(),
                ),
                _buildMenuButton(
                  context,
                  title: 'Keg. Akademis',
                  icon: Icons.school,
                  color: Colors.blue[700]!,
                  page: AcademicActivityPage(),
                ),
                _buildMenuButton(
                  context,
                  title: 'Kalender',
                  icon: Icons.date_range,
                  color: Colors.blue[700]!,
                  page: KalenderPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required String title, required IconData icon, required Color color, required Widget page}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, -8, 0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20), backgroundColor: color,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MenuPage(),
  ));
}
