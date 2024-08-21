import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';

import 'Google_Service_AdminBeranda.dart';

class AdminBerandaScreen extends StatefulWidget {
  const AdminBerandaScreen({Key? key}) : super(key: key);

  @override
  State<AdminBerandaScreen> createState() => _AdminBerandaScreenState();
}

class _AdminBerandaScreenState extends State<AdminBerandaScreen> {
  late Google_Service_AdminBeranda _googleService;
  List<ChartData> _chartData = [];
  List<DemographicData> _demographicData = [];
  int _totalPopulation = 0;
  double _successRate = 0.0;

  bool _isLoading = true;
  DateTimeRange? _selectedDateRange;
  List<ChartData> _filteredChartData = [];

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    _googleService = Google_Service_AdminBeranda();
    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      final sessionData = await _googleService.getSessionSummary();
      final demographicData = await _googleService.getDemographicData();
      final totalPopulation = await _googleService.getTotalPopulation();
      final successRate = await _googleService.getSuccessRate();

      setState(() {
        _chartData = sessionData;
        _demographicData = demographicData;
        _totalPopulation = totalPopulation;
        _successRate = successRate;
        _filteredChartData = _filterChartData(sessionData);
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<ChartData> _filterChartData(List<ChartData> data) {
    if (_selectedDateRange == null) return data;
    return data.where((item) {
      return item.date.isAfter(_selectedDateRange!.start) &&
          item.date.isBefore(_selectedDateRange!.end);
    }).toList();
  }

  Future<void> _selectDateRange() async {
    DateTimeRange? newRange = await showDialog<DateTimeRange>(
      context: context,
      builder: (BuildContext context) {
        DateTimeRange? selectedRange;
        return AlertDialog(
          title: const Text('Pilih Rentang Tanggal'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final pickedRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        initialDateRange: selectedRange,
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: Colors.green,
                              hintColor: Colors.green,
                              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedRange != null) {
                        setState(() {
                          selectedRange = pickedRange;
                        });
                      }
                    },
                    child: Text(selectedRange == null
                        ? 'Pilih Rentang Tanggal'
                        : DateFormat('MMM dd, yyyy').format(selectedRange!.start) + ' - ' + DateFormat('MMM dd, yyyy').format(selectedRange!.end)),
                  ),
                  if (selectedRange != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(selectedRange);
                        },
                        child: const Text('Terapkan'),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );

    if (newRange != null) {
      setState(() {
        _selectedDateRange = newRange;
        _filteredChartData = _filterChartData(_chartData);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SIPADES - Beranda Admin'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Permintaan Surat',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _selectDateRange,
                  child: const Text('Filter Berdasarkan Tanggal'),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 250,
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat('MMM dd'),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      minimum: 0,
                      maximum: 800,
                      interval: 200,
                    ),
                    series: <ChartSeries>[
                      LineSeries<ChartData, DateTime>(
                        dataSource: _filteredChartData,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.count,
                        name: '2023',
                        color: Colors.blue,
                      ),
                      LineSeries<ChartData, DateTime>(
                        dataSource: _filteredChartData,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.count + 100,
                        name: '2024',
                        color: Colors.green,
                      ),
                    ],
                    tooltipBehavior: TooltipBehavior(enable: true),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Total Penduduk',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CircularProgressIndicator(
                                value: _totalPopulation / 10000,
                                color: Colors.green,
                                strokeWidth: 10,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _totalPopulation.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Total Penduduk'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Terdaftar di Aplikasi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CircularProgressIndicator(
                                value: _successRate,
                                color: Colors.green,
                                strokeWidth: 10,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                (_successRate * 100).toStringAsFixed(0),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Daily Average'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Demographics',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 200,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              minimum: 0,
                              maximum: 35,
                              interval: 10,
                            ),
                            series: <ChartSeries>[
                              BarSeries<DemographicData, String>(
                                dataSource: _demographicData,
                                xValueMapper: (DemographicData data, _) => data.label,
                                yValueMapper: (DemographicData data, _) => data.value,
                                color: Colors.green,
                              ),
                            ],
                            tooltipBehavior: TooltipBehavior(enable: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Presentasi Keberhasilan Surat',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${(_successRate * 100).toStringAsFixed(2)}%',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Goal Conversion Rate',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: _successRate,
                          backgroundColor: Colors.grey,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
