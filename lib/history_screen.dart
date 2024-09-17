import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Google_Service_UserRiwayat.dart';

class HistoryScreen extends StatefulWidget {
  final String username; // Pass username here

  const HistoryScreen({Key? key, required this.username}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _googleService = GoogleServiceUserRiwayat('145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
  late Future<List<Map<String, String>>> _futureRiwayat;
  String _selectedStatus = 'Semua Status';
  DateTime? _selectedDate;
  String _selectedJenisSurat = 'Semua Jenis Surat';

  @override
  void initState() {
    super.initState();
    _futureRiwayat = _googleService.fetchUserRiwayat(widget.username);
  }

  void _filterOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _selectedStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
                items: <String>[
                  'Semua Status',
                  'Berhasil',
                  'Menunggu Diproses',
                  'Gagal',
                  'Diterima'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              TextField(
                readOnly: true,
                onTap: _selectDate,
                decoration: InputDecoration(
                  hintText: _selectedDate == null
                      ? 'Pilih Tanggal'
                      : 'Tanggal: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                value: _selectedJenisSurat,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedJenisSurat = newValue!;
                  });
                },
                items: <String>[
                  'Semua Jenis Surat',
                  'Jenis Surat 1',
                  'Jenis Surat 2'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _applyFilters();
              },
              child: const Text('Terapkan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      // Apply filters to future request
      _futureRiwayat = _googleService.fetchUserRiwayat(widget.username); // Refetch with filters applied
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Pengajuan'),
          centerTitle: true,
          automaticallyImplyLeading: false, // Tidak menampilkan tombol kembali
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Surat',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _filterOptions,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.filter_list, size: 20.0),
                            const SizedBox(width: 8.0),
                            Text(
                              'Filtering',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              FutureBuilder<List<Map<String, String>>>(
                future: _futureRiwayat,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading data');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Tidak ada Riwayat');
                  }

                  final transactions = snapshot.data!;
                  return Column(
                    children: transactions.map((DataRiwayat) {
                      return _TransactionItem(
                        status: DataRiwayat['status'] ?? '',
                        jenisSurat: DataRiwayat['jenisSurat'] ?? '',
                        tanggalPengajuan: DataRiwayat['tanggalPengajuan'] ?? '',
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Username adalah: ${widget.username}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop();
            },
            child: const Text('Iya'),
          ),
        ],
      ),
    );

    return shouldExit ?? false;
  }
}

class _TransactionItem extends StatelessWidget {
  final String status;
  final String jenisSurat;
  final String tanggalPengajuan;

  const _TransactionItem({
    Key? key,
    required this.status,
    required this.jenisSurat,
    required this.tanggalPengajuan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SURAT', // This is the fixed text
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Jenis Surat: $jenisSurat',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Tanggal Pengajuan: $tanggalPengajuan',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
//
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Berhasil':
        return Colors.green;
      case 'Menunggu Diproses':
        return Colors.yellow;
      case 'Gagal':
        return Colors.red;
      case 'Diterima':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
