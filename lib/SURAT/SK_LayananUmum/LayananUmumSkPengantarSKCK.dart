import 'package:flutter/material.dart';
import 'package:flutter_searchable_dropdown/flutter_searchable_dropdown.dart';
import 'GoogleService_AgamaXKerja.dart';

class LayananUmumSkPengantarSKCK extends StatefulWidget {
  @override
  _LayananUmumSkPengantarSKCKState createState() => _LayananUmumSkPengantarSKCKState();
}

class _LayananUmumSkPengantarSKCKState extends State<LayananUmumSkPengantarSKCK> {
  // Kunci global untuk form agar dapat memvalidasi input
  final _formKey = GlobalKey<FormState>();

  // Kontroler untuk setiap field input
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

  // Daftar agama dan pekerjaan yang akan ditampilkan di dropdown
  List<String> _agamaList = [];
  List<String> _pekerjaanList = [];

  // Variabel untuk menyimpan nilai yang dipilih dari dropdown
  String? _selectedAgama;
  String? _selectedPekerjaan;
  String? _selectedAgamaAnak;
  String? _selectedPekerjaanAnak;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Memanggil fungsi untuk mengambil data dari Google Sheets
  }

  // Fungsi untuk mengambil data agama dan pekerjaan dari Google Sheets
  Future<void> _fetchData() async {
    final googleService = GoogleService_AgamaXKerja(sheetId: '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI');
    final data = await googleService.fetchAgama();

    setState(() {
      // Mengupdate daftar agama dan pekerjaan dengan data yang diambil
      _agamaList = data['agama'] ?? [];
      _pekerjaanList = data['pekerjaan'] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Pengantar SKCK'), // Judul aplikasi di AppBar
        backgroundColor: Colors.indigo, // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding untuk body
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Kunci untuk validasi form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan semua anak ke kiri
              children: [
                const Text(
                  'Persyaratan:', // Judul untuk bagian persyaratan
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Style teks
                ),
                const SizedBox(height: 10),
                _buildRequirementText('• Fotocopy Akta Kelahiran'), // Persyaratan 1
                _buildRequirementText('• Fotocopy Kartu Tanda Penduduk (KTP)'), // Persyaratan 2
                _buildRequirementText('• Fotocopy Kartu Keluarga masing-masing fotocopy 2 lembar'), // Persyaratan 3
                _buildRequirementText('• Pas Foto berlatarbelakang merah ukuran 4x6 sebanyak 6 lembar'), // Persyaratan 4
                _buildRequirementText('• Seluruh berkas dimasukkan ke dalam Map kertas warna kuning'), // Persyaratan 5
                _buildRequirementText('\nCatatan: Mohon Membawa Persyaratan Berkas Saat Pengambilan Surat'), // Catatan tambahan
                const Divider(height: 30, thickness: 2), // Pembatas antar bagian

                _buildSectionTitle('Data Pemohon'), // Judul section Data Pemohon
                _buildTextField(_namaController, 'Masukkan Nama'), // Input field untuk Nama
                _buildTextField(_umurController, 'Masukkan Umur', inputType: TextInputType.number), // Input field untuk Umur
                _buildSearchableDropdown('Agama', _agamaList, _selectedAgama, (value) {
                  setState(() {
                    _selectedAgama = value; // Menyimpan pilihan agama ke variabel
                  });
                }),
                _buildSearchableDropdown('Pekerjaan', _pekerjaanList, _selectedPekerjaan, (value) {
                  setState(() {
                    _selectedPekerjaan = value; // Menyimpan pilihan pekerjaan ke variabel
                  });
                }),
                _buildTextField(_alamatController, 'Masukkan Alamat'), // Input field untuk Alamat

                const Divider(height: 30, thickness: 2), // Pembatas antar bagian

                _buildSectionTitle('Data Istri'), // Judul section Data Istri
                _buildTextField(_namaIstriController, 'Masukkan Nama Istri'), // Input field untuk Nama Istri
                _buildTextField(_umurIstriController, 'Masukkan Umur Istri', inputType: TextInputType.number), // Input field untuk Umur Istri
                _buildSearchableDropdown('Agama', _agamaList, _selectedAgama, (value) {
                  setState(() {
                    _selectedAgama = value; // Menyimpan pilihan agama istri ke variabel
                  });
                }),
                _buildSearchableDropdown('Pekerjaan', _pekerjaanList, _selectedPekerjaan, (value) {
                  setState(() {
                    _selectedPekerjaan = value; // Menyimpan pilihan pekerjaan istri ke variabel
                  });
                }),
                _buildTextField(_alamatIstriController, 'Masukkan Alamat Istri'), // Input field untuk Alamat Istri

                const Divider(height: 30, thickness: 2), // Pembatas antar bagian

                _buildSectionTitle('Data Anak'), // Judul section Data Anak
                _buildTextField(_nikAnakController, 'Masukkan NIK Anak'), // Input field untuk NIK Anak
                _buildTextField(_namaAnakController, 'Masukkan Nama Anak'), // Input field untuk Nama Anak
                _buildTextField(_umurAnakController, 'Masukkan Umur Anak', inputType: TextInputType.number), // Input field untuk Umur Anak
                _buildTextField(_alamatAnakController, 'Masukkan Alamat Anak'), // Input field untuk Alamat Anak
                _buildSearchableDropdown('Agama Anak', _agamaList, _selectedAgamaAnak, (value) {
                  setState(() {
                    _selectedAgamaAnak = value; // Menyimpan pilihan agama anak ke variabel
                  });
                }),
                _buildSearchableDropdown('Pekerjaan Anak', _pekerjaanList, _selectedPekerjaanAnak, (value) {
                  setState(() {
                    _selectedPekerjaanAnak = value; // Menyimpan pilihan pekerjaan anak ke variabel
                  });
                }),

                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0), // Padding tombol
                      backgroundColor: Colors.indigo, // Warna latar belakang tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Bentuk tombol
                      ),
                    ),
                    onPressed: () {
                      // Validasi form sebelum mengirim data
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data berhasil dikirim!')), // Pesan snackbar setelah kirim
                        );
                      }
                    },
                    child: const Text('Kirim', style: TextStyle(fontSize: 16, color: Colors.white)), // Teks tombol
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk membangun TextField dengan kontroler dan hint text
  Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1, TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType, // Menentukan jenis keyboard yang ditampilkan
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(), // Style border TextField
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Padding di dalam TextField
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field ini wajib diisi'; // Pesan validasi jika field kosong
          }
          return null;
        },
      ),
    );
  }

  // Widget untuk membangun Dropdown yang dapat dicari
  Widget _buildSearchableDropdown(String label, List<String> items, String? selectedValue, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // Border warna abu-abu untuk dropdown
          borderRadius: BorderRadius.circular(4.0), // Sudut dropdown yang melengkung
        ),
        child: SearchableDropdown.single(
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          value: selectedValue,
          hint: Text(label), // Label dropdown
          searchHint: Text('Search...'), // Hint pencarian
          onChanged: onChanged, // Fungsi yang dipanggil saat item dropdown dipilih
          isExpanded: true, // Membuat dropdown memanjang ke seluruh lebar
          underline: SizedBox(), // Menghilangkan underline default
        ),
      ),
    );
  }

  // Widget untuk membangun judul section dengan style tertentu
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Style teks judul
      ),
    );
  }

  // Widget untuk membangun teks persyaratan dengan padding bawah
  Widget _buildRequirementText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 14)), // Style teks persyaratan
    );
  }
}
