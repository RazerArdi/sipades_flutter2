import 'package:flutter/material.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'GoogleService_AgamaXKerja.dart';

class LayananUmumSkPengantarSKCK extends StatefulWidget {
  @override
  _LayananUmumSkPengantarSKCKState createState() => _LayananUmumSkPengantarSKCKState();
}

class _LayananUmumSkPengantarSKCKState extends State<LayananUmumSkPengantarSKCK> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  final TextEditingController _namaIstriController = TextEditingController();
  final TextEditingController _umurIstriController = TextEditingController();
  final TextEditingController _alamatIstriController = TextEditingController();

  final TextEditingController _nikAnakController = TextEditingController();
  final TextEditingController _namaAnakController = TextEditingController();
  final TextEditingController _umurAnakController = TextEditingController();
  final TextEditingController _alamatAnakController = TextEditingController();

  List<String> _agamaList = [];
  List<String> _pekerjaanList = [];
  String? _selectedAgama;
  String? _selectedPekerjaan;
  String? _selectedAgamaAnak;
  String? _selectedPekerjaanAnak;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final googleService = GoogleService_AgamaXKerja(sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
    final data = await googleService.fetchAgama();

    setState(() {
      _agamaList = data['agama'] ?? [];
      _pekerjaanList = data['pekerjaan'] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Pengantar SKCK'),
        backgroundColor: Colors.indigo,
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
                _buildRequirementText('• Fotocopy Akta Kelahiran'),
                _buildRequirementText('• Fotocopy Kartu Tanda Penduduk (KTP)'),
                _buildRequirementText('• Fotocopy Kartu Keluarga masing-masing fotocopy 2 lembar'),
                _buildRequirementText('• Pas Foto berlatarbelakang merah ukuran 4x6 sebanyak 6 lembar'),
                _buildRequirementText('• Seluruh berkas dimasukkan ke dalam Map kertas warna kuning'),
                _buildRequirementText('\nCatatan: Mohon Membawa Persyaratan Berkas Saat Pengambilan Surat'),
                const Divider(height: 30, thickness: 2),

                _buildSectionTitle('Data Pemohon'),
                _buildTextField(_namaController, 'Masukkan Nama'),
                _buildTextField(_umurController, 'Masukkan Umur', inputType: TextInputType.number),
                _buildSearchableDropdown('Agama', _agamaList, _selectedAgama, (value) {
                  setState(() {
                    _selectedAgama = value;
                  });
                }),
                _buildSearchableDropdown('Pekerjaan', _pekerjaanList, _selectedPekerjaan, (value) {
                  setState(() {
                    _selectedPekerjaan = value;
                  });
                }),
                _buildTextField(_alamatController, 'Masukkan Alamat'),

                const Divider(height: 30, thickness: 2),

                _buildSectionTitle('Data Istri'),
                _buildTextField(_namaIstriController, 'Masukkan Nama Istri'),
                _buildTextField(_umurIstriController, 'Masukkan Umur Istri', inputType: TextInputType.number),
                _buildSearchableDropdown('Agama', _agamaList, _selectedAgama, (value) {
                  setState(() {
                    _selectedAgama = value;
                  });
                }),
                _buildSearchableDropdown('Pekerjaan', _pekerjaanList, _selectedPekerjaan, (value) {
                  setState(() {
                    _selectedPekerjaan = value;
                  });
                }),
                _buildTextField(_alamatIstriController, 'Masukkan Alamat Istri'),

                const Divider(height: 30, thickness: 2),

                _buildSectionTitle('Data Anak'),
                _buildTextField(_nikAnakController, 'Masukkan NIK Anak'),
                _buildTextField(_namaAnakController, 'Masukkan Nama Anak'),
                _buildTextField(_umurAnakController, 'Masukkan Umur Anak', inputType: TextInputType.number),
                _buildTextField(_alamatAnakController, 'Masukkan Alamat Anak'),
                _buildSearchableDropdown('Agama Anak', _agamaList, _selectedAgamaAnak, (value) {
                  setState(() {
                    _selectedAgamaAnak = value;
                  });
                }),
                _buildSearchableDropdown('Pekerjaan Anak', _pekerjaanList, _selectedPekerjaanAnak, (value) {
                  setState(() {
                    _selectedPekerjaanAnak = value;
                  });
                }),

                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                      backgroundColor: Colors.indigo,
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
                    child: const Text('Kirim', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1, TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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

  Widget _buildSearchableDropdown(String label, List<String> items, String? selectedValue, void Function(String?) onChanged) {
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
          searchHint: Text('Search...'),
          onChanged: onChanged,
          isExpanded: true,
          underline: SizedBox(),
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
