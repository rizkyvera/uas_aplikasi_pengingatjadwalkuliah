import 'package:flutter/material.dart';

class Jadwal {
  String namaMataKuliah;
  String jamPelajaran;
  String ruangan;
  String namaDosen;

  Jadwal({
    required this.namaMataKuliah,
    required this.jamPelajaran,
    required this.ruangan,
    required this.namaDosen,
  });
}

class JadwalPage extends StatefulWidget {
  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage>
    with SingleTickerProviderStateMixin {
  int _jumlahJadwal = 1;
  List<Widget> _formJadwal = [];
  List<Jadwal> _daftarJadwal = [];

  late AnimationController _animationController;
  late Animation<Color?> _animation;

  

  @override
  void initState() {
    super.initState();
    _generateFormJadwal();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = ColorTween(
      begin: Colors.red,
      end: Colors.purple,
    ).animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateFormJadwal() {
    _formJadwal = List.generate(
      _jumlahJadwal,
      (index) => _buildFormJadwal(index),
    );
  }

  Widget _buildFormJadwal(int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Jadwal Kuliah ${index + 1}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Nama Mata Kuliah',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontSize: 16),
                prefixIcon: Icon(Icons.book, color: Colors.indigo),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
              onChanged: (value) {
                _daftarJadwal[index].namaMataKuliah = value;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Jam Pelajaran',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontSize: 16),
                prefixIcon: Icon(Icons.access_time, color: Colors.indigo),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
              onChanged: (value) {
                _daftarJadwal[index].jamPelajaran = value;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Ruangan',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontSize: 16),
                prefixIcon: Icon(Icons.room, color: Colors.indigo),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
              onChanged: (value) {
                _daftarJadwal[index].ruangan = value;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Nama Dosen',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontSize: 16),
                prefixIcon: Icon(Icons.person, color: Colors.indigo),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
              onChanged: (value) {
                _daftarJadwal[index].namaDosen = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToOutputPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutputPage(daftarJadwal: _daftarJadwal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Kuliah'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Jumlah Jadwal Kuliah',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_numbered, color: Colors.indigo),
              ),
              onChanged: (value) {
                setState(() {
                  _jumlahJadwal = int.tryParse(value) ?? 1;
                  _daftarJadwal.clear();
                  for (int i = 0; i < _jumlahJadwal; i++) {
                    _daftarJadwal.add(Jadwal(
                      namaMataKuliah: '',
                      jamPelajaran: '',
                      ruangan: '',
                      namaDosen: '',
                    ));
                  }
                  _generateFormJadwal();
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Isi Detail Jadwal Kuliah',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 10),
            ..._formJadwal,
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _navigateToOutputPage,
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                'Tambah',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutputPage extends StatelessWidget {
  final List<Jadwal> daftarJadwal;

  OutputPage({required this.daftarJadwal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Kuliah'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('No', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              numeric: true,
            ),
            DataColumn(
              label: Text('Mata Kuliah', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              tooltip: 'Nama Mata Kuliah',
            ),
            DataColumn(
              label: Text('Jam', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              tooltip: 'Jam Pelajaran',
            ),
            DataColumn(
              label: Text('Ruangan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              tooltip: 'Ruangan Kuliah',
            ),
            DataColumn(
              label: Text('Dosen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              tooltip: 'Nama Dosen',
            ),
          ],
          rows: daftarJadwal.asMap().entries.map((entry) {
            return DataRow(
              cells: [
                DataCell(
                  Text('${entry.key + 1}', style: TextStyle(fontSize: 16)),
                  showEditIcon: false,
                ),
                DataCell(
                  Text(entry.value.namaMataKuliah, style: TextStyle(fontSize: 16)),
                  showEditIcon: false,
                ),
                DataCell(
                  Text(entry.value.jamPelajaran, style: TextStyle(fontSize: 16)),
                  showEditIcon: false,
                ),
                DataCell(
                  Text(entry.value.ruangan, style: TextStyle(fontSize: 16)),
                  showEditIcon: false,
                ),
                DataCell(
                  Row(
                    children: [
                      Text(entry.value.namaDosen, style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Icon(Icons.person, size: 18, color: Colors.indigo),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.indigo),
                        onPressed: () {
                          // Add function to add to calendar
                        },
                      ),
                    ],
                  ),
                  showEditIcon: false,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: JadwalPage(),
  ));
}
