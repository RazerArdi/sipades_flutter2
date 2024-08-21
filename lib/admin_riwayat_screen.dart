import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GoogleService_AdminDataMasuk.dart';

class AdminRiwayatScreen extends StatefulWidget {
  @override
  _AdminRiwayatScreenState createState() => _AdminRiwayatScreenState();
}

class _AdminRiwayatScreenState extends State<AdminRiwayatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final double _borderThickness = 2.0;
  final GoogleService_AdminDataMasuk _sheetsService = GoogleService_AdminDataMasuk();

  Map<String, List<Map<String, String>>> _data = {
    'Semua': [],
    'Menunggu Diproses': [],
    'Diproses': [],
    'Diterima': [],
    'Berhasil': [],
    'Gagal': [],
  };

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 6,
      vsync: this,
    );
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await _sheetsService.fetchData();
    setState(() {
      _data['Semua'] = data;
      _data['Menunggu Diproses'] = data.where((item) => item['Status'] == 'Menunggu Diproses').toList();
      _data['Diproses'] = data.where((item) => item['Status'] == 'Diproses').toList();
      _data['Diterima'] = data.where((item) => item['Status'] == 'Diterima').toList();
      _data['Berhasil'] = data.where((item) => item['Status'] == 'Berhasil').toList();
      _data['Gagal'] = data.where((item) => item['Status'] == 'Gagal').toList();
      _isLoading = false;
    });
  }

  Future<void> _handleStatusChange() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchData();
    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar dari halaman ini?'),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DATA'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Column(
              children: [
                Container(
                  color: Colors.red,
                  height: _borderThickness,
                ),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: [
                    Tab(child: _buildTab('Semua')),
                    Tab(child: _buildTab('Menunggu Diproses')),
                    Tab(child: _buildTab('Diproses')),
                    Tab(child: _buildTab('Diterima')),
                    Tab(child: _buildTab('Berhasil')),
                    Tab(child: _buildTab('Gagal')),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
          controller: _tabController,
          children: [
            RiwayatList(
              status: 'Semua',
              data: _data['Semua']!,
              sheetsService: _sheetsService,
              onStatusChanged: _handleStatusChange,
            ),
            RiwayatList(
              status: 'Menunggu Diproses',
              data: _data['Menunggu Diproses']!,
              sheetsService: _sheetsService,
              onStatusChanged: _handleStatusChange,
            ),
            RiwayatList(
              status: 'Diproses',
              data: _data['Diproses']!,
              sheetsService: _sheetsService,
              onStatusChanged: _handleStatusChange,
            ),
            RiwayatList(
              status: 'Diterima',
              data: _data['Diterima']!,
              sheetsService: _sheetsService,
              onStatusChanged: _handleStatusChange,
            ),
            RiwayatList(
              status: 'Berhasil',
              data: _data['Berhasil']!,
              sheetsService: _sheetsService,
              onStatusChanged: _handleStatusChange,
            ),
            RiwayatList(
              status: 'Gagal',
              data: _data['Gagal']!,
              sheetsService: _sheetsService,
              onStatusChanged: _handleStatusChange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class RiwayatList extends StatefulWidget {
  final String status;
  final List<Map<String, String>> data;
  final GoogleService_AdminDataMasuk sheetsService;
  final VoidCallback onStatusChanged;

  RiwayatList({
    required this.status,
    required this.data,
    required this.sheetsService,
    required this.onStatusChanged,
  });

  @override
  _RiwayatListState createState() => _RiwayatListState();
}

class _RiwayatListState extends State<RiwayatList> {
  late List<Map<String, String>> filteredData;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filterData();
  }

  @override
  void didUpdateWidget(covariant RiwayatList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _filterData();
  }

  void _filterData() {
    if (widget.status == 'Semua') {
      filteredData = widget.data;
    } else {
      filteredData = widget.data.where((item) => item['Status'] == widget.status).toList();
    }
    if (searchQuery.isNotEmpty) {
      filteredData = filteredData.where((item) {
        final lowerCaseQuery = searchQuery.toLowerCase();
        final namaLengkap = item['Nama Lengkap']?.toLowerCase() ?? '';
        final tanggal = item['Tanggal']?.toLowerCase() ?? '';
        final jenisSurat = item['Jenis Surat']?.toLowerCase() ?? '';
        return namaLengkap.contains(lowerCaseQuery) ||
            tanggal.contains(lowerCaseQuery) ||
            jenisSurat.contains(lowerCaseQuery);
      }).toList();
    }
  }

  void _onSearchQueryChanged(String query) {
    setState(() {
      searchQuery = query;
      _filterData();
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Menunggu Diproses':
        return Colors.orange;
      case 'Diproses':
        return Colors.blue;
      case 'Diterima':
        return Colors.green;
      case 'Berhasil':
        return Colors.greenAccent;
      case 'Gagal':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _changeStatus(BuildContext context, Map<String, String> item) async {
    String? newStatus = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ubah Status'),
          content: DropdownButton<String>(
            isExpanded: true,
            value: item['Status'],
            items: ['Menunggu Diproses', 'Diproses', 'Diterima', 'Berhasil', 'Gagal']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              Navigator.of(context).pop(newValue);
            },
          ),
        );
      },
    );

    if (newStatus != null && newStatus != item['Status']) {
      item['Status'] = newStatus;
      await widget.sheetsService.updateStatus(item['ID']!, newStatus);
      widget.onStatusChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Cari Berdasarkan Nama',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _onSearchQueryChanged,
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final item = filteredData[index];
              final statusColor = _getStatusColor(item['Status'] ?? '');

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['Nama Lengkap'] ?? '',
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Divider(color: Colors.grey[300]),
                    const SizedBox(height: 8.0),
                    Text('Waktu: ${item['Waktu']}'),
                    const SizedBox(height: 4.0),
                    Text('Tanggal: ${item['Tanggal']}'),
                    const SizedBox(height: 4.0),
                    Text('Jenis Surat: ${item['Jenis Surat']}'),
                    const SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () => _changeStatus(context, item),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          item['Status'] ?? '',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
