import 'package:flutter/material.dart';

class LayananUmumSkTidakMampuSekolah extends StatefulWidget {
  @override
  _LayananUmumSkTidakMampuSekolahState createState() => _LayananUmumSkTidakMampuSekolahState();
}

class _LayananUmumSkTidakMampuSekolahState extends State<LayananUmumSkTidakMampuSekolah> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tempatTanggalLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _noKKController = TextEditingController();
  final TextEditingController _rtRwController = TextEditingController();
  final TextEditingController _desaController = TextEditingController();

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
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Syarat Pengajuan Rekomendasi SKTM untuk Sekolah:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildRequirementText('• Surat Keterangan Tidak Mampu cap Desa dan diketahui Camat setempat'),
              _buildRequirementText('• Fotokopi Akte Kelahiran Anak dan KTP Orang Tua'),
              _buildRequirementText('• Fotokopi Kartu Keluarga'),
              _buildRequirementText('• Fotokopi Kartu Keluarga Sejahtera (KKS) PKH depan dan belakang'),
              _buildRequirementText('• Fotokopi struk EDC dari KKS PKH'),
              _buildRequirementText('\nCatatan: Mohon Membawa Persyaratan Berkas Saat Pengambilan Surat'),
              const Divider(height: 30, thickness: 2),

              _buildSectionTitle('Identitas Pengajuan'),
              _buildTextField(_nikController, 'Masukkan NIK'),
              _buildTextField(_namaController, 'Masukkan Nama'),
              _buildTextField(_tempatTanggalLahirController, 'Masukkan Tempat, Tanggal Lahir'),

              _buildSectionTitle('Jenis Kelamin'),
              DropdownButtonFormField<String>(
                value: jenisKelamin,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['Laki-Laki', 'Perempuan'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    jenisKelamin = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Golongan Darah'),
              DropdownButtonFormField<String>(
                value: golonganDarah,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['A', 'B', 'AB', 'O'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    golonganDarah = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Agama'),
              DropdownButtonFormField<String>(
                value: agama,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    agama = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Pendidikan Terakhir'),
              DropdownButtonFormField<String>(
                value: pendidikanTerakhir,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['SD', 'SMP', 'SMA', 'Diploma', 'Sarjana'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    pendidikanTerakhir = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Status Pernikahan'),
              DropdownButtonFormField<String>(
                value: statusPernikahan,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['Belum Menikah', 'Menikah', 'Cerai Hidup', 'Cerai Mati'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    statusPernikahan = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Kewarganegaraan'),
              DropdownButtonFormField<String>(
                value: kewarganegaraan,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['Indonesia', 'Asing'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    kewarganegaraan = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildTextField(_pekerjaanController, 'Masukkan Pekerjaan'),
              _buildTextField(_noKKController, 'Masukkan No. KK'),
              _buildTextField(_alamatController, 'Masukkan Alamat'),
              _buildTextField(_rtRwController, 'Masukkan RT / RW'),
              _buildTextField(_desaController, 'Masukkan Desa'),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data berhasil dikirim!')),
                    );
                  },
                  child: const Text('Kirim', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        maxLines: maxLines,
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
