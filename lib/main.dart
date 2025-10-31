import 'package:flutter/material.dart';


void main() {
  runApp(const CateringApp());
}

class CateringApp extends StatelessWidget {
  const CateringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cemin Catering',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Menggunakan font yang bersih dan mudah dibaca
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// =================================================================
// 1. Halaman Utama (MainScreen) dengan BottomNavigationBar
// =================================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Daftar Widget/Halaman yang akan ditampilkan di BottomNavigationBar
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MenuPage(),
    OrderPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cemin Catering', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: Center(
        // Menampilkan halaman yang dipilih berdasarkan index
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // Implementasi BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesanan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// =================================================================
// 2. Halaman Beranda (HomePage)
// =================================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Kartu Sambutan
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang di Cemin Catering!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Temukan pilihan terbaik nasi kotak dan kue untuk acara Anda. Cepat, lezat, dan terpercaya.',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Bagian Promo / Featured Items
          const Text(
            'Menu Unggulan Hari Ini',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          _buildFeaturedItem(
            context,
            'Nasi Liwet Komplit',
            'Menu favorit untuk acara besar!',
            Icons.rice_bowl,
            Colors.orange,
          ),
          _buildFeaturedItem(
            context,
            'Kue Lapis Legit',
            'Manis, lembut, dan otentik.',
            Icons.cake,
            Colors.pink,
          ),

          const SizedBox(height: 20),
          // Aksi Cepat
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigasi ke Halaman Menu (simulasi, karena di MainScreen sudah dikendalikan oleh BottomNav)
                // Dalam aplikasi nyata, ini bisa memanggil fungsi _onItemTapped(1)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengalihkan ke Menu... (Tekan ikon Menu di bawah)')),
                );
              },
              icon: const Icon(Icons.search, color: Colors.white),
              label: const Text('Lihat Semua Menu', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedItem(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Contoh penggunaan Navigator.push() untuk navigasi ke halaman Detail
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProductPage(productName: title),
            ),
          );
        },
      ),
    );
  }
}

// =================================================================
// 3. Halaman Daftar Menu (MenuPage)
// =================================================================

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Pilihan Nasi Kotak & Kue',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 15),
          // Kategori Nasi Kotak
          const Text('Rice Box', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          _buildMenuItem(context, 'Rice Box (Ayam Bakar)', 25000, 'Lauk lengkap dengan sambal dan lalapan.'),
          _buildMenuItem(context, 'Rice Box (Ikan Balado)', 28000, 'Pilihan pedas manis yang menggugah selera.'),
          const SizedBox(height: 20),

          // Kategori Kue
          const Text('Cakes & Snacks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          _buildMenuItem(context, 'Kelepon Unyu', 5000, 'Kue tradisional dengan aroma pandan.'),
          _buildMenuItem(context, 'Brownies Cokelat', 150000, 'Satu loyang brownies premium.'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String name, int price, String description) {
    String formattedPrice = 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.fastfood, color: Colors.teal),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$formattedPrice\n$description'),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
          onPressed: () {
            // Contoh aksi tambah ke keranjang (hanya simulasi)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$name ditambahkan ke keranjang!')),
            );
          },
        ),
        onTap: () {
          // Navigasi ke halaman detail produk
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProductPage(productName: name),
            ),
          );
        },
      ),
    );
  }
}

// =================================================================
// 4. Halaman Pesanan (OrderPage)
// =================================================================

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Keranjang & Status Pesanan',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 15),
          // Simulasi Daftar Keranjang
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildOrderCartItem('Rice Box (Ayam Bakar)', 2, 50000),
                _buildOrderCartItem('Brownies Cokelat ', 1, 150000),
                ListTile(
                  title: const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  trailing: Text('Rp 200.000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red.shade600)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Tombol Checkout
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Contoh penggunaan Navigator.pushReplacement() untuk menyelesaikan proses order dan kembali ke Home
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfirmationPage(), // Navigasi ke halaman ke-4 opsional
                  ),
                );
              },
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: const Text('Checkout Sekarang', style: TextStyle(color: Colors.white, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCartItem(String name, int quantity, int subtotal) {
    String formattedSubtotal = 'Rp ${subtotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        title: Text(name),
        subtitle: Text('Jumlah: $quantity'),
        trailing: Text(formattedSubtotal, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
      ),
    );
  }
}

// =================================================================
// 5. Halaman Detail Produk (Contoh Navigasi Lanjutan - Halaman ke-4)
// =================================================================

class DetailProductPage extends StatelessWidget {
  final String productName;
  const DetailProductPage({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.info, size: 80, color: Colors.teal),
              const SizedBox(height: 20),
              Text(
                'Detail Produk: $productName',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ini adalah halaman detail yang diakses menggunakan Navigator.push() dari halaman utama atau menu.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  // Contoh penggunaan Navigator.pop() untuk kembali ke halaman sebelumnya
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =================================================================
// 6. Halaman Konfirmasi (Contoh Navigasi Lanjutan - Halaman ke-5)
// =================================================================

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Pesanan'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Menyembunyikan tombol kembali
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Pesanan Berhasil Dibuat!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 10),
              const Text(
                'Pesanan Anda akan segera diproses. Terima kasih telah memesan di Rasa Nusantara.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigator.popUntil untuk kembali ke halaman utama (MainScreen)
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text('Kembali ke Beranda', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}