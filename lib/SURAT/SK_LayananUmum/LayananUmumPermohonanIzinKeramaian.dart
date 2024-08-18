import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LayananUmumPermohonanIzinKeramaian extends StatefulWidget {
  @override
  _LayananUmumPermohonanIzinKeramaianState createState() => _LayananUmumPermohonanIzinKeramaianState();
}

class _LayananUmumPermohonanIzinKeramaianState extends State<LayananUmumPermohonanIzinKeramaian> {
  String? jenisKelamin;
  String? hajat;
  String? lama;
  String? hari;
  String? tempatAcara;
  String? selectedDate;

  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  final TextEditingController _tglAcaraController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        controller.text = selectedDate!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permohonan Izin Keramaian Pesta'),
        backgroundColor: Colors.pink,
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
              _buildRequirementText('• Surat Keterangan dari Kelurahan Setempat'),
              _buildRequirementText('• Fotocopy KTP yang punya Hajad sebanyak 1 (satu) Lembar'),
              _buildRequirementText('• Fotocopy KK yang punya Hajad sebanyak 1 (satu) Lembar'),
              _buildRequirementText('\nCatatan: Mohon Membawa Persyaratan Berkas Saat Pengambilan Surat'),
              const Divider(height: 30, thickness: 2),

              const Text(
                'Identitas Pengajuan:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              _buildSectionTitle('NIK'),
              _buildTextField(_nikController, 'Masukkan NIK'),

              _buildSectionTitle('Nama'),
              _buildTextField(_namaController, 'Masukkan Nama'),

              _buildSectionTitle('Tanggal Lahir, Umur'),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, _tglLahirController),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _tglLahirController,
                          decoration: InputDecoration(
                            hintText: 'Pilih Tanggal Lahir',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(_umurController, 'Masukkan Umur'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildSectionTitle('Pekerjaan'),
              _buildTextField(_pekerjaanController, 'Masukkan Pekerjaan'),

              _buildSectionTitle('Alamat Asal'),
              _buildTextField(_alamatController, 'Masukkan Alamat', maxLines: 3),

              const Divider(height: 30, thickness: 2),

              const Text(
                'Detail Acara:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              _buildSectionTitle('Hajat'),
              _buildTextField(TextEditingController(), 'Masukkan Hajat'),

              _buildSectionTitle('Lama'),
              _buildTextField(TextEditingController(), 'Masukkan Lama'),

              _buildSectionTitle('Hari'),
              _buildTextField(TextEditingController(), 'Masukkan Hari'),

              _buildSectionTitle('Tanggal'),
              GestureDetector(
                onTap: () => _selectDate(context, _tglAcaraController),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _tglAcaraController,
                    decoration: InputDecoration(
                      hintText: 'Pilih Tanggal Acara',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
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

              _buildSectionTitle('Tempat Acara'),
              _buildTextField(TextEditingController(), 'Masukkan Tempat Acara'),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    backgroundColor: Colors.pink,
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
