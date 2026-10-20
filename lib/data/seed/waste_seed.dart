import 'package:flutter/material.dart';
import '../../models/waste_category.dart';
import '../../models/waste_item.dart';

const wasteCategories = <WasteCategory>[
  WasteCategory(id: 'organik', name: 'Organik', description: 'Sisa alami yang dapat terurai.', examples: ['Sisa sayur', 'Kulit buah', 'Daun kering'], howTo: 'Pisahkan dari plastik dan bahan berbahaya. Cacah bila perlu, lalu olah menjadi kompos.', icon: Icons.eco_rounded, color: Color(0xFFE4F3E7)),
  WasteCategory(id: 'plastik', name: 'Plastik', description: 'Kemasan plastik yang dapat dipilah.', examples: ['Botol PET', 'Wadah bersih', 'Kantong plastik'], howTo: 'Kosongkan isi, bilas jika memungkinkan, keringkan, lalu pisahkan berdasarkan jenis plastik.', icon: Icons.recycling_rounded, color: Color(0xFFE4F0F7)),
  WasteCategory(id: 'kertas', name: 'Kertas', description: 'Kertas dan kardus yang masih bersih.', examples: ['Kardus', 'Koran', 'Kertas tulis'], howTo: 'Pastikan kering dan tidak berminyak. Lipat kardus agar lebih ringkas sebelum disetor.', icon: Icons.menu_book_rounded, color: Color(0xFFFFF0D8)),
  WasteCategory(id: 'kaca', name: 'Kaca', description: 'Botol dan wadah kaca.', examples: ['Botol kaca', 'Toples'], howTo: 'Pisahkan dari sampah lain. Bungkus pecahan kaca dengan aman dan beri tanda sebelum dibuang.', icon: Icons.wine_bar_rounded, color: Color(0xFFE8E5F8)),
  WasteCategory(id: 'logam', name: 'Logam', description: 'Kaleng dan kemasan berbahan logam.', examples: ['Kaleng minuman', 'Kaleng makanan'], howTo: 'Kosongkan dan bilas kaleng. Hindari tepi tajam saat merapikan dan setor ke pengumpul daur ulang.', icon: Icons.inventory_2_rounded, color: Color(0xFFF7E8DF)),
  WasteCategory(id: 'b3', name: 'B3 & Elektronik', description: 'Sampah berbahaya dan elektronik.', examples: ['Baterai', 'Lampu', 'Kabel'], howTo: 'Jangan dicampur dengan sampah rumah tangga. Simpan terpisah dan cari titik pengumpulan khusus.', icon: Icons.battery_alert_rounded, color: Color(0xFFFFE8E5)),
];

const wasteItems = <WasteItem>[
  WasteItem(id: 'botol_pet', name: 'Botol plastik', categoryId: 'plastik', description: 'Botol minuman plastik yang umumnya bertanda PET.', handling: 'Kosongkan, bilas, keringkan, lalu pipihkan jika aman. Lepaskan tutup bila fasilitas setempat meminta pemisahan.', icon: Icons.local_drink_rounded),
  WasteItem(id: 'kulit_buah', name: 'Kulit buah', categoryId: 'organik', description: 'Sisa kulit buah dari kegiatan sehari-hari.', handling: 'Pisahkan dari kemasan. Potong kecil dan masukkan ke komposter yang sesuai.', icon: Icons.spa_rounded),
  WasteItem(id: 'kardus', name: 'Kardus', categoryId: 'kertas', description: 'Kemasan kertas tebal yang bersih dan kering.', handling: 'Lepaskan selotip berlebihan, ratakan kardus, dan simpan di tempat kering.', icon: Icons.inventory_2_rounded),
  WasteItem(id: 'kaleng', name: 'Kaleng minuman', categoryId: 'logam', description: 'Kemasan minuman berbahan aluminium atau logam.', handling: 'Kosongkan dan bilas. Perhatikan bagian yang tajam sebelum disimpan untuk didaur ulang.', icon: Icons.local_drink_rounded),
  WasteItem(id: 'botol_kaca', name: 'Botol kaca', categoryId: 'kaca', description: 'Wadah kaca yang dapat digunakan kembali atau didaur ulang.', handling: 'Pisahkan dari bahan lain. Jangan masukkan pecahan kaca tanpa pembungkus yang aman.', icon: Icons.wine_bar_rounded),
  WasteItem(id: 'baterai', name: 'Baterai bekas', categoryId: 'b3', description: 'Baterai yang sudah habis atau tidak terpakai.', handling: 'Jangan dibakar atau dibuka. Simpan di tempat kering dan setorkan ke titik pengumpulan limbah khusus.', icon: Icons.battery_alert_rounded),
  WasteItem(id: 'sisa_makanan', name: 'Sisa makanan', categoryId: 'organik', description: 'Sisa makanan tanpa kemasan dan bahan non-organik.', handling: 'Pisahkan tulang atau bahan yang tidak sesuai dengan komposter. Kurangi sisa makanan sejak awal.', icon: Icons.restaurant_rounded),
  WasteItem(id: 'kertas_tulis', name: 'Kertas tulis', categoryId: 'kertas', description: 'Kertas tulis yang tidak terkena minyak atau cairan.', handling: 'Jaga tetap kering dan satukan dengan kertas bersih untuk didaur ulang.', icon: Icons.description_rounded),
];

const guideSteps = <({String title, String description, IconData icon})>[
  (title: 'Kenali jenis sampah', description: 'Periksa bahan utama dan label pada kemasan sebelum memilah.', icon: Icons.search_rounded),
  (title: 'Pisahkan berdasarkan kategori', description: 'Sediakan tempat berbeda untuk organik, anorganik, dan limbah khusus.', icon: Icons.category_rounded),
  (title: 'Bersihkan dan keringkan', description: 'Kosongkan sisa isi kemasan agar bahan daur ulang tidak tercemar.', icon: Icons.water_drop_rounded),
  (title: 'Simpan dengan aman', description: 'Lindungi bahan tajam dan jauhkan baterai atau limbah B3 dari sampah biasa.', icon: Icons.shield_rounded),
  (title: 'Salurkan ke tempat yang tepat', description: 'Gunakan komposter, bank sampah, atau titik pengumpulan sesuai jenisnya.', icon: Icons.local_shipping_rounded),
];
