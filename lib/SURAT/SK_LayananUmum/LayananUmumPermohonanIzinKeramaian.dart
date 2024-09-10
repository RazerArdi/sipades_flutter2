import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

// Widget utama untuk menampilkan form permohonan izin keramaian
class LayananUmumPermohonanIzinKeramaian extends StatefulWidget {
  @override
  _LayananUmumPermohonanIzinKeramaianState createState() => _LayananUmumPermohonanIzinKeramaianState();
}

class _LayananUmumPermohonanIzinKeramaianState extends State<LayananUmumPermohonanIzinKeramaian> {
  String? jenisKelamin; // Menyimpan jenis kelamin yang dipilih
  String? hajat; // Menyimpan hajat/acara yang diadakan
  String? lama; // Menyimpan lama acara
  String? hari; // Menyimpan hari acara
  String? tempatAcara; // Menyimpan tempat acara
  String? selectedDate; // Menyimpan tanggal yang dipilih

  // Kontroller untuk mengelola input text field
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _tglAcaraController = TextEditingController();

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Tanggal awal default adalah hari ini
      firstDate: DateTime(1900), // Tanggal pertama yang bisa dipilih
      lastDate: DateTime(2100), // Tanggal terakhir yang bisa dipilih
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"; // Mengatur tanggal yang dipilih
        controller.text = selectedDate!; // Menyimpan tanggal yang dipilih ke text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permohonan Izin Keramaian Pesta'), // Judul aplikasi di AppBar
        backgroundColor: Colors.pink, // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding untuk body
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan anak ke kiri
            children: [
              const Text(
                'Keterangan Persyaratan:', // Judul bagian keterangan persyaratan
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), // Style teks
              ),
              const SizedBox(height: 12),
              _buildRequirementText('• Surat Keterangan dari Kelurahan Setempat'), // Persyaratan 1
              _buildRequirementText('• Fotocopy KTP yang punya Hajad sebanyak 1 (satu) Lembar'), // Persyaratan 2
              _buildRequirementText('• Fotocopy KK yang punya Hajad sebanyak 1 (satu) Lembar'), // Persyaratan 3
              _buildRequirementText('\nCatatan: Mohon Membawa Persyaratan Berkas Saat Pengambilan Surat'), // Catatan tambahan
              const Divider(height: 30, thickness: 2), // Pembatas antar bagian

              const Text(
                'Identitas Pengajuan:', // Judul bagian identitas pengajuan
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), // Style teks
              ),
              const SizedBox(height: 12),

              _buildSectionTitle('NIK'), // Judul section NIK
              _buildTextField(_nikController, 'Masukkan NIK'), // Input field untuk NIK

              _buildSectionTitle('Nama'), // Judul section Nama
              _buildTextField(_namaController, 'Masukkan Nama'), // Input field untuk Nama

              _buildSectionTitle('Tanggal Lahir, Umur'), // Judul section Tanggal Lahir dan Umur
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, _tglLahirController), // Memilih tanggal lahir saat field di-tap
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _tglLahirController,
                          decoration: InputDecoration(
                            hintText: 'Pilih Tanggal Lahir', // Hint text untuk tanggal lahir
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(_umurController, 'Masukkan Umur'), // Input field untuk Umur
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Pekerjaan'), // Judul section Pekerjaan
              _buildTextField(_pekerjaanController, 'Masukkan Pekerjaan'), // Input field untuk Pekerjaan

              _buildSectionTitle('Alamat Asal'), // Judul section Alamat Asal
              _buildTextField(_alamatController, 'Masukkan Alamat', maxLines: 3), // Input field untuk Alamat

              const Divider(height: 30, thickness: 2), // Pembatas antar bagian

              const Text(
                'Detail Acara:', // Judul bagian Detail Acara
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), // Style teks
              ),
              const SizedBox(height: 12),

              _buildSectionTitle('Hajat'), // Judul section Hajat
              _buildTextField(TextEditingController(), 'Masukkan Hajat'), // Input field untuk Hajat

              _buildSectionTitle('Lama'), // Judul section Lama
              _buildTextField(TextEditingController(), 'Masukkan Lama'), // Input field untuk Lama

              _buildSectionTitle('Hari'), // Judul section Hari
              _buildTextField(TextEditingController(), 'Masukkan Hari'), // Input field untuk Hari

              _buildSectionTitle('Tanggal'), // Judul section Tanggal
              GestureDetector(
                onTap: () => _selectDate(context, _tglAcaraController), // Memilih tanggal acara saat field di-tap
                child: AbsorbPointer(
                  child: TextField(
                    controller: _tglAcaraController,
                    decoration: InputDecoration(
                      hintText: 'Pilih Tanggal Acara', // Hint text untuk tanggal acara
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Jenis Kelamin'), // Judul section Jenis Kelamin
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Laki-Laki'),
                      value: 'Laki-Laki',
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value; // Menyimpan jenis kelamin yang dipilih
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
                          jenisKelamin = value; // Menyimpan jenis kelamin yang dipilih
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Tempat Acara'), // Judul section Tempat Acara
              _buildTextField(TextEditingController(), 'Masukkan Tempat Acara'), // Input field untuk Tempat Acara

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    backgroundColor: Colors.pink, // Warna latar belakang tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Sudut tombol membulat
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data berhasil dikirim!')), // Menampilkan snackbar saat tombol diklik
                    );
                  },
                  child: const Text('Kirim', style: TextStyle(fontSize: 16)), // Teks tombol
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membangun judul section dengan style khusus
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  // Widget untuk membangun TextField dengan kontroler dan hint text
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

  // Widget untuk membangun teks persyaratan dengan padding bawah
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
