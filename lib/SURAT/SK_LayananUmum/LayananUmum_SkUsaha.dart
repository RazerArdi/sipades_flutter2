import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'GoogleServiceAPI_Kabupaten.dart';

class LayananUmumSkUsaha extends StatefulWidget {
  @override
  _LayananUmumSkUsahaState createState() => _LayananUmumSkUsahaState();
}

class _LayananUmumSkUsahaState extends State<LayananUmumSkUsaha> {
  String? selectedKabupaten;
  String? jenisKelamin;
  String agama = 'Islam';
  String statusPerkawinan = 'Belum Menikah';
  String? selectedDate;

  List<String> kabupatenList = [];
  bool isLoading = true;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

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
        _dateController.text = selectedDate!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Keterangan Usaha'),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Keterangan Persyaratan:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _buildRequirementText('• Surat Pengantar RT & RW'),
              _buildRequirementText('• Fotocopy KK'),
              _buildRequirementText('• Fotocopy KTP'),
              _buildRequirementText('\nCatatan : Mohon Membawa Persyaratan Berkas Saat Pengambilan Surat'),
              const Divider(height: 30, thickness: 2),

              _buildSectionTitle('NIK'),
              _buildTextField(_nikController, 'Masukkan NIK'),

              _buildSectionTitle('Nama'),
              _buildTextField(_namaController, 'Masukkan Nama'),

              _buildSectionTitle('Tempat, Tanggal Lahir'),
              Row(
                children: [
                  Expanded(
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : DropdownSearch<String>(
                      popupProps: PopupProps.menu(showSearchBox: true),
                      items: kabupatenList,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Pilih Kabupaten",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Jenis Kelamin'),
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

              _buildSectionTitle('Agama'),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                ),
                value: agama,
                items: ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu'].map((String value) {
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

              _buildSectionTitle('Status Perkawinan'),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                ),
                value: statusPerkawinan,
                items: ['Belum Menikah', 'Menikah', 'Cerai Hidup', 'Cerai Mati'].map((String value) {
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

              _buildSectionTitle('Pekerjaan'),
              _buildTextField(_pekerjaanController, 'Masukkan Pekerjaan'),

              _buildSectionTitle('Alamat'),
              _buildTextField(_alamatController, 'Masukkan Alamat', maxLines: 3),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data berhasil dikirim!')),
                    );
                  },
                  child: const Text('Kirim', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
      maxLines: maxLines,
    );
  }

  Widget _buildRequirementText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
