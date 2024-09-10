import 'package:flutter/material.dart'; // Mengimpor paket Flutter Material
import 'package:flutter/services.dart'; // Mengimpor paket untuk mengontrol sistem (misalnya keluar dari aplikasi)

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  // Fungsi ini akan dipanggil ketika pengguna mencoba untuk menekan tombol kembali
  Future<bool> _onWillPop(BuildContext context) async {
    // Menampilkan dialog konfirmasi untuk keluar dari aplikasi
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Jika pengguna memilih 'Tidak', keluar dari dialog tanpa menutup aplikasi
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Jika pengguna memilih 'Iya', keluar dari dialog
              SystemNavigator.pop(); // Menutup aplikasi
            },
            child: const Text('Iya'),
          ),
        ],
      ),
    );

    return shouldExit ?? false; // Mengembalikan nilai 'true' atau 'false' berdasarkan pilihan pengguna
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context), // Menangani aksi tombol kembali
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menyusun elemen secara vertikal di tengah
            children: [
              Image.asset(
                'assets/images/confused.png', // Menampilkan gambar untuk menandakan bahwa halaman kosong
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Yahhh... Halaman ini kosong',
                style: TextStyle(
                  fontSize: 16, // Ukuran font untuk teks
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
