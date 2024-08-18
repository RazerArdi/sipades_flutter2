import 'package:flutter/material.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'GoogleService_AgamaXKerja.dart';
import 'GoogleServiceAPI_Kabupaten.dart';

class LayananUmumSkTempatUsaha extends StatefulWidget {
  @override
  _LayananUmumSkTempatUsahaState createState() =>
      _LayananUmumSkTempatUsahaState();
}

class _LayananUmumSkTempatUsahaState extends State<LayananUmumSkTempatUsaha> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _alamatAsalController = TextEditingController();
  final TextEditingController _kewarganegaraanController =
  TextEditingController();
  final TextEditingController _pendidikanAkhirController =
  TextEditingController();
  final TextEditingController _namaUsahaController = TextEditingController();
  final TextEditingController _jenisUsahaController = TextEditingController();
  final TextEditingController _alamatUsahaController = TextEditingController();

  List<String> _agamaList = [];
  List<String> _pekerjaanList = [];
  List<String> _kabupatenList = [];
  String? _selectedAgama;
  String? _selectedPekerjaan;
  String? _selectedKabupaten;
  String? _selectedJenisKelamin;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchKabupaten();
  }

  Future<void> _fetchData() async {
    final googleService = GoogleService_AgamaXKerja(
        sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
    final data = await googleService.fetchAgama();

    setState(() {
      _agamaList = data['agama'] ?? [];
      _pekerjaanList = data['pekerjaan'] ?? [];
    });
  }

  Future<void> _fetchKabupaten() async {
    final googleService = GoogleServiceAPI_Kabupaten(sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
    final data = await googleService.fetchKabupaten();

    setState(() {
      _kabupatenList = data;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Keterangan Tempat Usaha'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Persyaratan:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildRequirementText(
                    '• Pengantar dari Wilayah RT/RW bagi yang berlokasi di wilayah setempat'),
                _buildRequirementText(
                    '• Pengantar dari perusahaan dan surat rekomendasi dari Paguyuban Lingkungan Industri Tambakaji (PLITA) bagi yang berada di Kawasan Industri'),
                _buildRequirementText(
                    '• Fotocopy KTP Pemohon / Penanggungjawab'),
                _buildRequirementText(
                    '• Fotocopy surat-surat diantaranya SIUP, TDP, NPWP'),
                _buildRequirementText(
                    '• Fotocopy surat domisili lama (permohonan perpanjangan domisili)'),
                const Divider(height: 30, thickness: 2),

                _buildSectionTitle('Data Pemohon'),
                _buildTextField(_nikController, 'Masukkan NIK'),
                _buildTextField(_namaController, 'Masukkan Nama'),

                _buildSectionTitle('Tempat, Tanggal Lahir'),
                Row(
                  children: [
                    Expanded(
                      child: _buildSearchableDropdown(
                        'Pilih Tempat Lahir',
                        _kabupatenList,
                        _selectedKabupaten,
                            (value) {
                          setState(() {
                            _selectedKabupaten = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: _buildTextField(
                            _tanggalLahirController,
                            'Pilih Tanggal Lahir',
                            inputType: TextInputType.datetime,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildSearchableDropdown('Jenis Kelamin', ['Pria', 'Wanita'],
                    _selectedJenisKelamin, (value) {
                      setState(() {
                        _selectedJenisKelamin = value;
                      });
                    }),
                _buildTextField(_alamatAsalController, 'Masukkan Alamat Asal'),
                _buildTextField(
                    _kewarganegaraanController, 'Masukkan Kewarganegaraan'),
                _buildTextField(
                    _pendidikanAkhirController, 'Masukkan Pendidikan Akhir'),
                _buildSearchableDropdown('Pekerjaan', _pekerjaanList,
                    _selectedPekerjaan, (value) {
                      setState(() {
                        _selectedPekerjaan = value;
                      });
                    }),

                const Divider(height: 30, thickness: 2),

                _buildSectionTitle('Data Usaha/Perusahaan'),
                _buildTextField(
                    _namaUsahaController, 'Masukkan Nama Usaha/Perusahaan'),
                _buildTextField(_jenisUsahaController, 'Masukkan Jenis Usaha'),
                _buildTextField(_alamatUsahaController,
                    'Masukkan Alamat Usaha/Perusahaan'),

                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 15.0),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data berhasil dikirim!')),
                        );
                      }
                    },
                    child: const Text('Kirim',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1, TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field ini wajib diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSearchableDropdown(String label, List<String> items,
      String? selectedValue, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: SearchableDropdown.single(
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          value: selectedValue,
          hint: Text(label),
          searchHint: const Text('Search...'),
          onChanged: onChanged,
          isExpanded: true,
          underline: const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRequirementText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}
