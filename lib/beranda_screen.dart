import 'package:flutter/material.dart';

class BerandaScreen extends StatelessWidget {
  final String username;

  const BerandaScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Siang',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ServiceItem(
                        icon: Icons.money_off,
                        label: 'Rp 0',
                        iconColor: Colors.white,
                        backgroundColor: Colors.purple,
                        labelColor: Colors.black,
                      ),
                      _ServiceItem(
                        icon: Icons.qr_code_scanner,
                        label: 'Scan',
                        iconColor: Colors.purple,
                        backgroundColor: Colors.grey[200]!,
                        labelColor: Colors.black,
                      ),
                      _ServiceItem(
                        icon: Icons.money,
                        label: 'Top Up',
                        iconColor: Colors.purple,
                        backgroundColor: Colors.grey[200]!,
                        labelColor: Colors.black,
                      ),
                      _ServiceItem(
                        icon: Icons.history,
                        label: 'Riwayat',
                        iconColor: Colors.purple,
                        backgroundColor: Colors.grey[200]!,
                        labelColor: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.local_offer, color: Colors.purple),
                          SizedBox(width: 8.0),
                          Text('RailPoin'),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        child: const Text('Premium'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Menu Layanan',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Pilih layanan yang Anda butuhkan',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16.0),
              children: const [
                _ServiceMenuItem(icon: Icons.train, label: 'Pesan Tiket'),
                _ServiceMenuItem(icon: Icons.money, label: 'Pembayaran'),
                _ServiceMenuItem(icon: Icons.history, label: 'Riwayat Pembayaran'),
                _ServiceMenuItem(icon: Icons.qr_code_scanner, label: 'QR Code'),
                _ServiceMenuItem(icon: Icons.card_giftcard, label: 'Voucher'),
                _ServiceMenuItem(icon: Icons.info, label: 'Info'),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Artikel Menarik',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _ArticleItem(
                    title: 'Menilik Sejarah Stasiun Klaten: Bangunan Belanda Berusia 153 Tahun',
                    imageUrl: 'assets/images/stasiun_klaten.jpg',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;
  final Color labelColor;

  const _ServiceItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
    required this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24.0, color: iconColor),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.0,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ServiceMenuItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40.0, color: Colors.purple),
        const SizedBox(height: 8.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}

class _ArticleItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const _ArticleItem({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
