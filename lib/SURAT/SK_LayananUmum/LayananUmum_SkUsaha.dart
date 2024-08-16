import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'GoogleServiceAPI_Kabupaten.dart'; // Ensure this import matches your file structure

class LayananUmumSkUsaha extends StatefulWidget {
  @override
  _LayananUmumSkUsahaState createState() => _LayananUmumSkUsahaState();
}

class _LayananUmumSkUsahaState extends State<LayananUmumSkUsaha> {
  String? selectedKabupaten;
  String? jenisKelamin;
  String agama = 'Islam';
  String statusPerkawinan = 'Belum Menikah';
  String? selectedDate; // To hold the selected date

  List<String> kabupatenList = []; // Updated to load dynamically
  bool isLoading = true; // Track loading state

  final TextEditingController _dateController = TextEditingController(); // Controller for date field

  @override
  void initState() {
    super.initState();
    _fetchKabupaten();
  }

  Future<void> _fetchKabupaten() async {
    try {
      final service = GoogleServiceAPI_Kabupaten(sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
      final kabupaten = await service.fetchKabupaten();
      setState(() {
        kabupatenList = kabupaten;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to load kabupaten: $e');
      setState(() {
        isLoading = false;
      });
      // Optionally handle the error, e.g., show an error message
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        _dateController.text = selectedDate!; // Update the text controller
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Keterangan Usaha'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Keterangan Persyaratan:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• Surat Pengantar RT & RW'),
              const Text('• Fotocopy KK'),
              const Text('• Fotocopy KTP'),
              const Divider(height: 20, thickness: 2),

              const Text('NIK'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan NIK',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Nama'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Tempat, Tanggal Lahir'),
              Row(
                children: [
                  Expanded(
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: kabupatenList,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Pilih Kabupaten",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedKabupaten = value;
                        });
                      },
                      selectedItem: selectedKabupaten,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            hintText: 'Pilih Tanggal',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text('Jenis Kelamin'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Laki-Laki'),
                      value: 'Laki-Laki',
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Perempuan'),
                      value: 'Perempuan',
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text('Agama'),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: agama,
                items: <String>[
                  'Islam',
                  'Kristen',
                  'Katolik',
                  'Hindu',
                  'Buddha',
                  'Konghucu'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    agama = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              const Text('Status Perkawinan'),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: statusPerkawinan,
                items: <String>[
                  'Belum Menikah',
                  'Menikah',
                  'Cerai Hidup',
                  'Cerai Mati'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    statusPerkawinan = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              const Text('Pekerjaan'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan Pekerjaan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Alamat'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan Alamat',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data berhasil dikirim!')),
                    );
                  },
                  child: const Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
