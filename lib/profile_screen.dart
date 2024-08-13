import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Space to replace AppBar height
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/user.png'), // Replace with your actual image
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nama Pengguna',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Informasi Akun',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
                trailing: Text('username@example.com'),
              ),
              const ListTile(
                leading: Icon(Icons.phone),
                title: Text('Nomor Telepon'),
                trailing: Text('08123456789'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Akun Saya',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildProfileItem(
                icon: Icons.delete_sweep,
                title: 'Hapus Cache',
                subtitle: '39.15MB',
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              _buildProfileItem(
                icon: Icons.lock,
                title: 'Ubah Kata Sandi',
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              _buildProfileItem(
                icon: Icons.info,
                title: 'Tentang Kami',
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              _buildProfileItem(
                icon: Icons.question_answer,
                title: 'FAQ',
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              _buildProfileItem(
                icon: Icons.privacy_tip,
                title: 'Kebijakan Privasi',
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              _buildProfileItem(
                icon: Icons.phone,
                title: 'Hubungi Kami',
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              _buildProfileItem(
                icon: Icons.share,
                title: 'Bagikan',
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Keluar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
    );
  }
}

