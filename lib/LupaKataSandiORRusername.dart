import 'package:flutter/material.dart';
import 'package:sipades_flutter2/LupaPasswordScreen.dart';
import 'package:sipades_flutter2/LupaUsernameScreen.dart';



class LupaKataSandiORRusername extends StatefulWidget {
  @override
  _LupaKataSandiORRusernameState createState() => _LupaKataSandiORRusernameState();
}

class _LupaKataSandiORRusernameState extends State<LupaKataSandiORRusername> {
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
            Card(
              child: ListTile(
                leading: Radio(
                  value: true,
                  groupValue: _isUsernameSelected,
                  onChanged: (value) {
                    setState(() {
                      _isUsernameSelected = value!;
                    });
                  },
                ),
                title: Text('Lupa Username'),
                subtitle: Text(
                  'Fitur lupa username digunakan untuk melihat kembali username (NIK atau ID KK) yang terdaftar',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: Radio(
                  value: false,
                  groupValue: _isUsernameSelected,
                  onChanged: (value) {
                    setState(() {
                      _isUsernameSelected = value!;
                    });
                  },
                ),
                title: Text('Lupa Password'),
                subtitle: Text(
                  'Fitur lupa password digunakan untuk membuat password kembali dan membuka blokir Akun BRImo',
                  style: TextStyle(fontSize: 12),
                ),
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
                  if (_isUsernameSelected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LupaUsernameScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LupaPasswordScreen()),
                    );
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
}//
