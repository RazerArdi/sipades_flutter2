import 'package:flutter/material.dart';

class LayananUmumSkTidakMampuSekolah extends StatefulWidget {
  @override
  _LayananUmumSkTidakMampuSekolahState createState() => _LayananUmumSkTidakMampuSekolahState();
}

class _LayananUmumSkTidakMampuSekolahState extends State<LayananUmumSkTidakMampuSekolah> {
  // Kontroler untuk setiap field input
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tempatTanggalLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _noKKController = TextEditingController();
  final TextEditingController _rtRwController = TextEditingController();
  final TextEditingController _desaController = TextEditingController();

  // Variabel untuk menyimpan nilai dropdown
  String jenisKelamin = 'Laki-Laki';
  String golonganDarah = 'A';
  String agama = 'Islam';
  String pendidikanTerakhir = 'SD';
  String statusPernikahan = 'Belum Menikah';
  String kewarganegaraan = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Keterangan Tidak Mampu (Sekolah)'),
        backgroundColor: Colors.purple, // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding untuk body
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan semua anak ke kiri
            children: [
              const Text(
                'Syarat Pengajuan Rekomendasi SKTM untuk Sekolah:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Style teks judul
              ),
              const SizedBox(height: 10),
              // Menampilkan daftar persyaratan
              _buildRequirementText('• Surat Keterangan Tidak Mampu cap Desa dan diketahui Camat setempat'),
              _buildRequirementText('• Fotokopi Akte Kelahiran Anak dan KTP Orang Tua'),
              _buildRequirementText('• Fotokopi Kartu Keluarga'),
              _buildRequirementText('• Fotokopi Kartu Keluarga Sejahtera (KKS) PKH depan dan belakang'),
              _buildRequirementText('• Fotokopi struk EDC dari KKS PKH'),
              _buildRequirementText('\nCatatan: Mohon Membawa Persyaratan Berkas Saat Pengambilan Surat'),
              const Divider(height: 30, thickness: 2), // Pembatas antar bagian

              // Bagian Identitas Pengajuan
              _buildSectionTitle('Identitas Pengajuan'),
              _buildTextField(_nikController, 'Masukkan NIK'),
              _buildTextField(_namaController, 'Masukkan Nama'),
              _buildTextField(_tempatTanggalLahirController, 'Masukkan Tempat, Tanggal Lahir'),

              // Bagian Jenis Kelamin
              _buildSectionTitle('Jenis Kelamin'),
              DropdownButtonFormField<String>(
                value: jenisKelamin, // Nilai yang dipilih saat ini
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style border dropdown
                items: ['Laki-Laki', 'Perempuan'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    jenisKelamin = newValue!; // Menyimpan pilihan jenis kelamin
                  });
                },
              ),
              const SizedBox(height: 16),

              // Bagian Golongan Darah
              _buildSectionTitle('Golongan Darah'),
              DropdownButtonFormField<String>(
                value: golonganDarah, // Nilai yang dipilih saat ini
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style border dropdown
                items: ['A', 'B', 'AB', 'O'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    golonganDarah = newValue!; // Menyimpan pilihan golongan darah
                  });
                },
              ),
              const SizedBox(height: 16),

              // Bagian Agama
              _buildSectionTitle('Agama'),
              DropdownButtonFormField<String>(
                value: agama, // Nilai yang dipilih saat ini
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style border dropdown
                items: ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    agama = newValue!; // Menyimpan pilihan agama
                  });
                },
              ),
              const SizedBox(height: 16),

              // Bagian Pendidikan Terakhir
              _buildSectionTitle('Pendidikan Terakhir'),
              DropdownButtonFormField<String>(
                value: pendidikanTerakhir, // Nilai yang dipilih saat ini
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style border dropdown
                items: ['SD', 'SMP', 'SMA', 'Diploma', 'Sarjana'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    pendidikanTerakhir = newValue!; // Menyimpan pilihan pendidikan terakhir
                  });
                },
              ),
              const SizedBox(height: 16),

              // Bagian Status Pernikahan
              _buildSectionTitle('Status Pernikahan'),
              DropdownButtonFormField<String>(
                value: statusPernikahan, // Nilai yang dipilih saat ini
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style border dropdown
                items: ['Belum Menikah', 'Menikah', 'Cerai Hidup', 'Cerai Mati'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    statusPernikahan = newValue!; // Menyimpan pilihan status pernikahan
                  });
                },
              ),
              const SizedBox(height: 16),

              // Bagian Kewarganegaraan
              _buildSectionTitle('Kewarganegaraan'),
              DropdownButtonFormField<String>(
                value: kewarganegaraan, // Nilai yang dipilih saat ini
                decoration: const InputDecoration(border: OutlineInputBorder()), // Style border dropdown
                items: ['Indonesia', 'Asing'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    kewarganegaraan = newValue!; // Menyimpan pilihan kewarganegaraan
                  });
                },
              ),
              const SizedBox(height: 16),

              // Field tambahan
              _buildTextField(_pekerjaanController, 'Masukkan Pekerjaan'),
              _buildTextField(_noKKController, 'Masukkan No. KK'),
              _buildTextField(_alamatController, 'Masukkan Alamat'),
              _buildTextField(_rtRwController, 'Masukkan RT / RW'),
              _buildTextField(_desaController, 'Masukkan Desa'),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0), // Padding tombol
                    backgroundColor: Colors.blue, // Warna latar belakang tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Bentuk tombol
                    ),
                  ),
                  onPressed: () {
                    // Tindakan yang diambil saat tombol diklik
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data berhasil dikirim!')), // Pesan snackbar setelah kirim
                    );
                  },
                  child: const Text('Kirim', style: TextStyle(fontSize: 16, color: Colors.white)), // Teks tombol
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
          hintText: hintText, // Teks petunjuk pada TextField
          border: const OutlineInputBorder(), // Style border TextField
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Padding konten TextField
        ),
        maxLines: maxLines, // Menentukan jumlah baris maksimal
      ),
    );
  }

  // Widget untuk membangun judul section dengan style tertentu
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), // Style teks judul
      ),
    );
  }

  // Widget untuk membangun teks persyaratan dengan padding bawah
  Widget _buildRequirementText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16), // Style teks persyaratan
      ),
    );
  }
}
