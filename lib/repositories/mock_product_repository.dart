import '../models/product.model.dart';
import 'product_repository.dart';

class MockProductRepository implements ProductRepository {
  final List<ProductModel> _products = const [
    ProductModel(
      id: 'BLZ-001',
      name: 'Jessica Model Örgü Bileklik',
      description:
          'İnce örgü dokusuyla dokunan geniş bileklik; parlak altın yüzeyi ve sağlam klipsiyle '
          'gündüzden geceye her kombine modern bir ışıltı katar. Çift kullanım için ideal bir çift.',
      images: [
        'assets/bileklikler/jessica_model_bileklik_1.jpg',
        'assets/bileklikler/jessica_model_bileklik_2.jpg',
      ],
      category: 'Bilezikler',
      isBestSeller: true,
      specs: {'Model': 'Jessica', 'Malzeme': 'Altın', 'Kapama': 'Klipsli'},
    ),
    ProductModel(
      id: 'BLZ-002',
      name: 'Zımbalı Altın Bileklik',
      description:
          'Dış yüzeyindeki zımbalı detaylarla cesur ve çağdaş bir ifade sunar. Yüksek parlaklıklı '
          'altın işçiliği, günlük şıklıktan özel günlere kadar dikkat çeken bir aksesuardır.',
      images: [
        'assets/bileklikler/zimbali_altin_bileklik_1.jpg',
        'assets/bileklikler/zimbali_altin_bileklik_2.jpg',
        'assets/bileklikler/zimbali_altin_bileklik_3.jpg',
      ],
      category: 'Bilezikler',
      isBestSeller: true,
      specs: {'Model': 'Zımbalı', 'Malzeme': 'Altın', 'Stil': 'Statement'},
    ),
    ProductModel(
      id: 'KLY-001',
      name: 'Baget Taşlı Gurmet Zincir Seti',
      description:
          'Gurmet zincir formunda kolye ve bileklik seti. Baget kesim taşlar, klasik zincir '
          'siluetine modern bir parlaklık ekler; özel günler ve günlük lüks için mükemmel bir ikili.',
      images: [
        'assets/zincirler/gurmet_zincir_kolye_1.jpg',
        'assets/zincirler/gurmet_zincir_kolye_2.jpg',
        'assets/zincirler/gurmet_zincir_kolye_3.jpg',
      ],
      category: 'Kolyeler',
      isBestSeller: true,
      specs: {'Parça': 'Kolye + Bileklik', 'Zincir': 'Gurmet', 'Taş': 'Baget kesim'},
    ),
    ProductModel(
      id: 'KLY-002',
      name: 'Parlak Zirkon Güneş Kolye',
      description:
          'Güneş formu pandantif ve pavé zirkon detaylarıyla ışıltılı bir tasarım. Boncuk zincir '
          'üzerinde zarif duruşu, hem tek başına hem katmanlı kullanımda göz kamaştırır.',
      images: [
        'assets/zincirler/parlak_zikon_tasli_kolye_1.jpg',
        'assets/zincirler/parlak_zikon_tasli_kolye_2.jpg',
        'assets/zincirler/parlak_zikon_tasli_kolye_3.jpg',
      ],
      category: 'Kolyeler',
      isBestSeller: true,
      specs: {'Pandantif': 'Güneş', 'Taş': 'Zirkon', 'Zincir': 'Boncuk'},
    ),
    ProductModel(
      id: 'KLY-003',
      name: 'Taşlı Gurmet Zincir Seti',
      description:
          'Kalın gurmet zincir ve üçlü halka pavé taşlı merkez detayıyla güçlü bir set. Kolye ve '
          'bileklik uyumu, koleksiyonun en iddialı parçalarından biri olarak öne çıkar.',
      images: [
        'assets/zincirler/tasli_gurmet_zincir_1.jpg',
        'assets/zincirler/tasli_gurmet_zincir_2.jpg',
      ],
      category: 'Kolyeler',
      isBestSeller: false,
      specs: {'Parça': 'Kolye + Bileklik', 'Zincir': 'Gurmet', 'Detay': 'Pavé halka'},
    ),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    return _products;
  }

  @override
  Future<List<ProductModel>> getBestSellers() async {
    return _products.where((product) => product.isBestSeller).toList();
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Map<String, String>> getCategoryCoverImages() async {
    return {
      'Kolyeler': _products.firstWhere((p) => p.category == 'Kolyeler').images[0],
      'Bilezikler': _products.firstWhere((p) => p.category == 'Bilezikler').images[0],
    };
  }
}
