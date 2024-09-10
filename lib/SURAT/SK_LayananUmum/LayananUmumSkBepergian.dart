import 'package:flutter/material.dart';

// Widget utama untuk form Surat Keterangan Bepergian
class LayananUmumSkBepergian extends StatefulWidget {
  @override
  _LayananUmumSkBepergianState createState() => _LayananUmumSkBepergianState();
}

class _LayananUmumSkBepergianState extends State<LayananUmumSkBepergian> {
  // Kontroler untuk semua input field
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tempatTanggalLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _noKKController = TextEditingController();
  final TextEditingController _rtRwController = TextEditingController();
  final TextEditingController _desaController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();

  final TextEditingController _tujuanController = TextEditingController();
  final TextEditingController _jalanController = TextEditingController();
  final TextEditingController _desaTujuanController = TextEditingController();
  final TextEditingController _kecamatanTujuanController = TextEditingController();
  final TextEditingController _kabupatenKotaController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _kodePosController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  // Variabel untuk menyimpan pilihan dari dropdown
  String jenisKelamin = 'Laki-Laki';
  String golonganDarah = 'A';
  String agama = 'Islam';
  String pendidikanTerakhir = 'SD';
  String kewarganegaraan = 'Indonesia';
  int jumlahPengikut = 0;

  // Daftar untuk menyimpan data pengikut
  List<Map<String, dynamic>> pengikut = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Keterangan Bepergian'), // Judul aplikasi di AppBar
        backgroundColor: Colors.lightGreen, // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding untuk body
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan anak ke kiri
            children: [
              const Text(
                'Persyaratan:', // Judul bagian persyaratan
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Style teks
              ),
              const SizedBox(height: 10),
              _buildRequirementText('• Surat Pengantar RT RW'), // Persyaratan 1
              _buildRequirementText('• Fotocopy dan asli KTP-el'), // Persyaratan 2
              _buildRequirementText('• Fotocopy dan asli KK'), // Persyaratan 3
              _buildRequirementText('• Alamat Lengkap dan nama tempat tujuan Bepergian/Perjalanan'), // Persyaratan 4
              _buildRequirementText('\nCatatan: Mohon Membawa Persyaratan Berkas Saat Pengambilan Surat'), // Catatan tambahan
              const Divider(height: 30, thickness: 2), // Pembatas antar bagian

              // Bagian Identitas Pengajuan
              _buildSectionTitle('Identitas Pengajuan'),
              _buildTextField(_nikController, 'Masukkan NIK'), // Input field untuk NIK
              _buildTextField(_namaController, 'Masukkan Nama'), // Input field untuk Nama
              _buildTextField(_tempatTanggalLahirController, 'Masukkan Tempat, Tanggal Lahir'), // Input field untuk Tempat dan Tanggal Lahir

              // Dropdown untuk memilih Jenis Kelamin
              _buildSectionTitle('Jenis Kelamin'),
              DropdownButtonFormField<String>(
                value: jenisKelamin, // Nilai awal dropdown
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style dropdown
                items: ['Laki-Laki', 'Perempuan'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    jenisKelamin = newValue!; // Menyimpan pilihan baru ke variabel
                  });
                },
              ),
              const SizedBox(height: 16),

              // Dropdown untuk memilih Golongan Darah
              _buildSectionTitle('Golongan Darah'),
              DropdownButtonFormField<String>(
                value: golonganDarah, // Nilai awal dropdown
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style dropdown
                items: ['A', 'B', 'AB', 'O'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    golonganDarah = newValue!; // Menyimpan pilihan baru ke variabel
                  });
                },
              ),
              const SizedBox(height: 16),

              // Dropdown untuk memilih Agama
              _buildSectionTitle('Agama'),
              DropdownButtonFormField<String>(
                value: agama, // Nilai awal dropdown
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style dropdown
                items: ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    agama = newValue!; // Menyimpan pilihan baru ke variabel
                  });
                },
              ),
              const SizedBox(height: 16),

              // Dropdown untuk memilih Pendidikan Terakhir
              _buildSectionTitle('Pendidikan Terakhir'),
              DropdownButtonFormField<String>(
                value: pendidikanTerakhir, // Nilai awal dropdown
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style dropdown
                items: ['SD', 'SMP', 'SMA', 'Diploma', 'Sarjana'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    pendidikanTerakhir = newValue!; // Menyimpan pilihan baru ke variabel
                  });
                },
              ),
              const SizedBox(height: 16),

              // Dropdown untuk memilih Kewarganegaraan
              _buildSectionTitle('Kewarganegaraan'),
              DropdownButtonFormField<String>(
                value: kewarganegaraan, // Nilai awal dropdown
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style dropdown
                items: ['Indonesia', 'Asing'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    kewarganegaraan = newValue!; // Menyimpan pilihan baru ke variabel
                  });
                },
              ),
              const SizedBox(height: 16),

              // Input fields untuk data alamat
              _buildTextField(_pekerjaanController, 'Masukkan Pekerjaan'),
              _buildTextField(_noKKController, 'Masukkan No. KK'),
              _buildTextField(_alamatController, 'Masukkan Alamat'),
              _buildTextField(_rtRwController, 'Masukkan RT / RW'),
              _buildTextField(_desaController, 'Masukkan Desa'),
              _buildTextField(_kecamatanController, 'Masukkan Kecamatan'),

              const Divider(height: 30, thickness: 2), // Pembatas antar bagian

              // Bagian Data Perjalanan
              _buildSectionTitle('Data Perjalanan'),
              _buildTextField(_tujuanController, 'Tujuan ke'), // Input field untuk Tujuan
              _buildTextField(_jalanController, 'Jalan'), // Input field untuk Jalan
              _buildTextField(_desaTujuanController, 'Desa / Kelurahan'), // Input field untuk Desa/Kelurahan
              _buildTextField(_kecamatanTujuanController, 'Kecamatan'), // Input field untuk Kecamatan
              _buildTextField(_kabupatenKotaController, 'Kabupaten/Kota'), // Input field untuk Kabupaten/Kota
              _buildTextField(_provinsiController, 'Provinsi'), // Input field untuk Provinsi
              _buildTextField(_kodePosController, 'Kode Pos'), // Input field untuk Kode Pos
              _buildTextField(_keteranganController, 'Keterangan'), // Input field untuk Keterangan

              const SizedBox(height: 16),

              // Dropdown untuk memilih jumlah pengikut
              _buildSectionTitle('Jumlah Pengikut'),
              DropdownButtonFormField<int>(
                value: jumlahPengikut, // Nilai awal dropdown
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style dropdown
                items: List.generate(6, (index) => index).map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value Orang'),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    jumlahPengikut = newValue!; // Menyimpan pilihan baru ke variabel
                    pengikut = List.generate(jumlahPengikut, (index) => {}); // Membuat list pengikut baru
                  });
                },
              ),

              const SizedBox(height: 16),
              // Formulir untuk setiap pengikut berdasarkan jumlah pengikut
              for (int i = 0; i < pengikut.length; i++) _buildPengikutForm(i),

              const SizedBox(height: 30),
              // Tombol Kirim
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0), // Padding tombol
                    backgroundColor: Colors.lightGreen, // Warna latar belakang tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Bentuk tombol
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data berhasil dikirim!')), // Pesan snackbar setelah kirim
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

  // Widget untuk membangun TextField dengan kontroler dan hint text
  Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(), // Style border TextField
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Padding di dalam TextField
        ),
        maxLines: maxLines,
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

  // Widget untuk membangun formulir pengikut
  Widget _buildPengikutForm(int index) {
    // Kontroler untuk input data pengikut
    final TextEditingController _namaPengikutController = TextEditingController();
    final TextEditingController _umurPengikutController = TextEditingController();
    final TextEditingController _nikPengikutController = TextEditingController();
    final TextEditingController _statusPengikutController = TextEditingController();
    final TextEditingController _pendidikanPengikutController = TextEditingController();
    final TextEditingController _keteranganPengikutController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Pengikut ${index + 1}'), // Judul untuk formulir pengikut
        _buildTextField(_namaPengikutController, 'Nama'), // Input field untuk Nama pengikut
        _buildTextField(_umurPengikutController, 'Umur'), // Input field untuk Umur pengikut
        _buildTextField(_nikPengikutController, 'NIK'), // Input field untuk NIK pengikut
        _buildTextField(_statusPengikutController, 'Status'), // Input field untuk Status pengikut
        _buildTextField(_pendidikanPengikutController, 'Pendidikan'), // Input field untuk Pendidikan pengikut
        _buildTextField(_keteranganPengikutController, 'Keterangan'), // Input field untuk Keterangan pengikut
        const SizedBox(height: 16),
      ],
    );
  }
}
