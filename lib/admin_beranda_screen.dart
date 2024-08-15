import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class AdminBerandaScreen extends StatefulWidget {
  const AdminBerandaScreen({Key? key}) : super(key: key);

  @override
  State<AdminBerandaScreen> createState() => _AdminBerandaScreenState();
}

class _AdminBerandaScreenState extends State<AdminBerandaScreen> {
  final List<ChartData> chartData = [
    ChartData(DateTime(2023, 1, 7), 500),
    ChartData(DateTime(2023, 1, 14), 350),
    ChartData(DateTime(2023, 1, 21), 150),
    ChartData(DateTime(2023, 1, 28), 650),
    ChartData(DateTime(2023, 2, 4), 300),
    ChartData(DateTime(2023, 2, 11), 150),
    ChartData(DateTime(2023, 2, 18), 300),
  ];

  final List<DemographicData> demographicData = [
    DemographicData('18-24', 15),
    DemographicData('25-34', 30),
    DemographicData('35-44', 18),
    DemographicData('45-54', 12),
    DemographicData('55-64', 15),
    DemographicData('65+', 5),
  ];

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Session Summary',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        name: '2021',
                        color: Colors.blue,
                      ),
                      LineSeries<ChartData, DateTime>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y + 100,
                        name: '2021',
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
                            children: const [
                              Text(
                                'Device Summary',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              CircularProgressIndicator(
                                value: 0.8,
                                color: Colors.green,
                                strokeWidth: 10,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '8203',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Total Users'),
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
                            children: const [
                              Text(
                                'New User Counts',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              CircularProgressIndicator(
                                value: 0.7,
                                color: Colors.green,
                                strokeWidth: 10,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '555',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Daily Average'),
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
                                dataSource: demographicData,
                                xValueMapper: (DemographicData data, _) =>
                                data.label,
                                yValueMapper: (DemographicData data, _) =>
                                data.value,
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
                          'Goal Conversion',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '69.34%',
                          style: TextStyle(
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
                          value: 0.69,
                          backgroundColor: Colors.grey,
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
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

class ChartData {
  final DateTime x;
  final int y;

  ChartData(this.x, this.y);
}

class DemographicData {
  final String label;
  final int value;

  DemographicData(this.label, this.value);
}
//