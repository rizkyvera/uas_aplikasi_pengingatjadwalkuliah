import 'package:flutter/material.dart';

class AcademicActivityPage extends StatefulWidget {
  @override
  _AcademicActivityPageState createState() => _AcademicActivityPageState();
}

class _AcademicActivityPageState extends State<AcademicActivityPage> {
  TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  TextEditingController _locationController = TextEditingController();
  List<Map<String, String>> _academicActivities = [];
  bool _showInputForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan Akademis'),
        backgroundColor: Colors.indigo,
      ),
      body: _showInputForm ? _buildInputForm() : AcademicActivityListPage(academicActivities: _academicActivities),
    );
  }

  Widget _buildInputForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tambah Kegiatan Akademis',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Judul Kegiatan',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.event, color: Colors.indigo),
            ),
          ),
          SizedBox(height: 10.0),
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: IgnorePointer(
              child: TextFormField(
                controller: TextEditingController(
                  text: _selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : "",
                ),
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.indigo),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Lokasi',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on, color: Colors.indigo),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton.icon(
            onPressed: () {
              _simpanKegiatan();
            },
            icon: Icon(Icons.add),
            label: Text('Simpan'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.indigo,
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _simpanKegiatan() {
    String title = _titleController.text;
    String date = _selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : "";
    String location = _locationController.text;

    if (title.isNotEmpty && date.isNotEmpty && location.isNotEmpty) {
      setState(() {
        _academicActivities.add({
          'title': title,
          'date': date,
          'location': location,
        });
        _titleController.clear();
        _selectedDate = null;
        _locationController.clear();
        _showInputForm = false; // Hide input form and show output list
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Peringatan'),
            content: Text('Semua kolom harus diisi untuk menyimpan kegiatan.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class AcademicActivityListPage extends StatelessWidget {
  final List<Map<String, String>> academicActivities;

  const AcademicActivityListPage({
    required this.academicActivities,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Daftar Kegiatan Akademis',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: academicActivities.length,
              itemBuilder: (context, index) {
                return AcademicActivityItem(
                  title: academicActivities[index]['title']!,
                  date: academicActivities[index]['date']!,
                  location: academicActivities[index]['location']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AcademicActivityItem extends StatelessWidget {
  final String title;
  final String date;
  final String location;

  const AcademicActivityItem({
    required this.title,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan logika untuk menambahkan ke kalender di sini
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text('Tambah ke Kalender'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.indigo,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'Tanggal: $date',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Lokasi: $location',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
