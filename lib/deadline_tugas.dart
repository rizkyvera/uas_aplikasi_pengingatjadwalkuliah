import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Deadline {
  String deskripsi;
  String tanggal;

  Deadline({required this.deskripsi, required this.tanggal});
}

class DeadlineTugasPage extends StatefulWidget {
  @override
  _DeadlineTugasPageState createState() => _DeadlineTugasPageState();
}

class _DeadlineTugasPageState extends State<DeadlineTugasPage> {
  TextEditingController _deskripsiController = TextEditingController();
  DateTime? _selectedDate;
  List<Deadline> _deadlines = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deadline Tugas'),
        backgroundColor: Colors.indigo[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tambah Deadline Tugas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildDeskripsiField(),
              SizedBox(height: 20),
              _buildTanggalButton(context),
              SizedBox(height: 20),
              _buildTambahButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeskripsiField() {
    return TextFormField(
      controller: _deskripsiController,
      decoration: InputDecoration(
        labelText: 'Deskripsi Tugas',
        filled: true,
        fillColor: Colors.indigo[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(Icons.description, color: Colors.indigo[900]),
      ),
    );
  }

  Widget _buildTanggalButton(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.calendar_today, color: Colors.indigo[900]),
      label: Text(
        _selectedDate != null
            ? 'Tanggal Deadline: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
            : 'Pilih Tanggal Deadline',
        style: TextStyle(color: Colors.indigo[900]),
      ),
      onPressed: () {
        _selectDate(context);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.indigo[900]!),
        ),
      ),
    );
  }

  Widget _buildTambahButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.add, color: Colors.white),
      label: Text('Tambah'),
      onPressed: () {
        _tambahDeadline(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo[900],
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
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

  void _tambahDeadline(BuildContext context) {
    String deskripsi = _deskripsiController.text;
    String? tanggal = _selectedDate != null
        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
        : null;

    if (deskripsi.isNotEmpty && tanggal != null) {
      
      setState(() {
        _deadlines.add(Deadline(deskripsi: deskripsi, tanggal: tanggal));
        _deskripsiController.clear();
        _selectedDate = null;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OutputPage(deadlines: _deadlines)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deskripsi dan Tanggal Deadline harus diisi.'),
        ),
      );
    }
  }
}

class OutputPage extends StatelessWidget {
  final List<Deadline> deadlines;

  OutputPage({required this.deadlines});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Deadline Tugas'),
        backgroundColor: Colors.indigo[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Daftar Deadlines',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: deadlines.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    child: ListTile(
                      leading: Icon(Icons.assignment, color: Colors.indigo[900]),
                      title: Text(
                        deadlines[index].deskripsi,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Tanggal Deadline: ${deadlines[index].tanggal}'),
                      trailing: ElevatedButton.icon(
                        icon: Icon(Icons.calendar_today, color: Colors.white),
                        label: Text('Tambah ke Kalender'),
                        onPressed: () {
                          _addEventToCalendar(deadlines[index]);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo[900],
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addEventToCalendar(Deadline deadline) async {
    String deskripsi = deadline.deskripsi;
    String tanggal = deadline.tanggal;
    String url = 'webcal://example.com/?action=TEMPLATE&text=$deskripsi&dates=$tanggal/$tanggal';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: DeadlineTugasPage(),
  ));
}