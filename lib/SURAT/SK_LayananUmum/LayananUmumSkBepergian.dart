import 'package:flutter/material.dart';

class LayananUmumSkBepergian extends StatefulWidget {
  @override
  _LayananUmumSkBepergianState createState() => _LayananUmumSkBepergianState();
}

class _LayananUmumSkBepergianState extends State<LayananUmumSkBepergian> {
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

  String jenisKelamin = 'Laki-Laki';
  String golonganDarah = 'A';
  String agama = 'Islam';
  String pendidikanTerakhir = 'SD';
  String kewarganegaraan = 'Indonesia';
  int jumlahPengikut = 0;

  List<Map<String, dynamic>> pengikut = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Keterangan Bepergian'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Persyaratan:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildRequirementText('• Surat Pengantar RT RW'),
              _buildRequirementText('• Fotocopy dan asli KTP-el'),
              _buildRequirementText('• Fotocopy dan asli KK'),
              _buildRequirementText('• Alamat Lengkap dan nama tempat tujuan Bepergian/Perjalanan'),
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
              _buildTextField(_kecamatanController, 'Masukkan Kecamatan'),

              const Divider(height: 30, thickness: 2),

              _buildSectionTitle('Data Perjalanan'),
              _buildTextField(_tujuanController, 'Tujuan ke'),
              _buildTextField(_jalanController, 'Jalan'),
              _buildTextField(_desaTujuanController, 'Desa / Kelurahan'),
              _buildTextField(_kecamatanTujuanController, 'Kecamatan'),
              _buildTextField(_kabupatenKotaController, 'Kabupaten/Kota'),
              _buildTextField(_provinsiController, 'Provinsi'),
              _buildTextField(_kodePosController, 'Kode Pos'),
              _buildTextField(_keteranganController, 'Keterangan'),

              const SizedBox(height: 16),
              _buildSectionTitle('Jumlah Pengikut'),
              DropdownButtonFormField<int>(
                value: jumlahPengikut,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: List.generate(6, (index) => index).map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value Orang'),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    jumlahPengikut = newValue!;
                    pengikut = List.generate(jumlahPengikut, (index) => {});
                  });
                },
              ),

              const SizedBox(height: 16),
              for (int i = 0; i < pengikut.length; i++) _buildPengikutForm(i),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    backgroundColor: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data berhasil dikirim!')),
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

  Widget _buildPengikutForm(int index) {
    final TextEditingController _namaPengikutController = TextEditingController();
    final TextEditingController _umurPengikutController = TextEditingController();
    final TextEditingController _nikPengikutController = TextEditingController();
    final TextEditingController _statusPengikutController = TextEditingController();
    final TextEditingController _pendidikanPengikutController = TextEditingController();
    final TextEditingController _keteranganPengikutController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Pengikut ${index + 1}'),
        _buildTextField(_namaPengikutController, 'Nama'),
        _buildTextField(_umurPengikutController, 'Umur'),
        _buildTextField(_nikPengikutController, 'NIK'),
        _buildTextField(_statusPengikutController, 'Status'),
        _buildTextField(_pendidikanPengikutController, 'Pendidikan'),
        _buildTextField(_keteranganPengikutController, 'Keterangan'),
        const SizedBox(height: 16),
      ],
    );
  }
}
