import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminProfilScreen extends StatelessWidget {
  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin keluar dari halaman ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SystemNavigator.pop();
            },
            child: const Text('Iya'),
          ),
        ],
      ),
    );

    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil Admin'),
          automaticallyImplyLeading: false,
        ),
        body: const Center(
          child: Text(
            'Profil Admin',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
