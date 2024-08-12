import 'package:flutter/material.dart';

class LupaPasswordScreen extends StatefulWidget {
  @override
  _LupaPasswordScreenState createState() => _LupaPasswordScreenState();
}

class _LupaPasswordScreenState extends State<LupaPasswordScreen> {
  bool _isUsernameSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: BackButton(color: Colors.white),
        title: Text(
          'Lupa Username/Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Lupa Username Atau Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pilih Lupa Username atau Password sesuai dengan kebutuhan kamu',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            // Opsi Lupa Username
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RadioListTile(
                title: Text('Lupa Username'),
                value: true,
                groupValue: _isUsernameSelected,
                onChanged: (value) {
                  setState(() {
                    _isUsernameSelected = value!;
                  });

                },

                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),

            SizedBox(height: 20),
            // Opsi Lupa Password
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RadioListTile(
                title: Text('Lupa Password'),
                value: false,
                groupValue: _isUsernameSelected,
                onChanged: (value) {
                  setState(() {
                    _isUsernameSelected = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Fitur lupa password digunakan untuk membuat password kembali dan membuka blokir Akun BRImo',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // Navigate to the next screen based on the selected option.
                  if (_isUsernameSelected) {
                    // Navigate to Lupa Username screen
                  } else {
                    // Navigate to Lupa Password screen
                  }
                },
                child: Text(
                  'Lanjutkan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}