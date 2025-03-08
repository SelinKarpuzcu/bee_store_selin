import 'dart:async';

import 'package:bee_store/parcalar/anasayfa_urun_widget.dart';
import 'package:bee_store/parcalar/category_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dosya.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Asenkron fonksiyon
  print("İlk işlem başarılı olarak çalıştırıldı.");
  islem(selamlamaMetni, sayi);

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Error: $e');
  }

  // Null Safety (?):
  String? baslik; // değişken Null olabilir demek

  // Null pointer Exception

  // Eğer bir değişkene ? işareti koymazsak o değişkene null değerini atayamayız hata verir.

  // String baslik2=null;    Error

  // Eğer bir değişkene ? işareti koymazsak ? işareti ve ! işaretini kullanamayız (ihtiyacımız yok).

  // print(baslik?.lenght); // Buradaki ? başlık değişkenine değer atanmamış olabilir bu yüzden buraya direk Null de
  //  gitsin demek. Burada print çalıştığında çıktısı Null olur.

  baslik = "başlık";

  print(baslik!
      .length); // Buradaki ! işareti kodu yazan kişi olarak ben kefilim bu değişken Null değil anlamını
  //  taşıyor.

  try {
    print(pozitifSayiTopla(-2, 12));
  } catch (e) {
    print('Error: $e');
  }

  // currentPlatform: bu fonksiyon hangi platformda çağırılırsa platformun ayarlarını getir.

  // Widget myApp= MaterialApp(
  //     // Uygulama mimarisi sunuyor.
  //     // fonksiyon çağırıyoruz , işlem çağırıyoruz. iki tane parametre yollayıp , ile ayırdık.
  //     debugShowCheckedModeBanner:
  //         isDebug, // sayfanın köşesindeki Debug yazısını kaldırır. // 1. parametreyi gönderdik
  //     home: Scaffold(   // Scaffold bir sayfanın mimarisini sunuyor.
  //       // parametre ismi home olan bir widget ı ":" ile göstererek 2.parametre olarak gönderdik
  //       appBar: AppBar(
  //         title: const Text("Home"),
  //         centerTitle: false,   // appBar daki title (Home yazısı) merkezde (ortada) olsun mu?
  //         actions: [
  //            // IconButton(
  //            //   icon: const Icon(Icons.notifications),   // appBar a icon ekledik
  //            //   onPressed:() {},  // butona tıklanınca ne olsun istiyoruz. onPressed parametresine fonksiyon gönderdik
  //            // ),
  //             IconButton(
  //               icon: Image.asset('varliklar/resimler/notification.png',
  //               width: 24,   // double
  //               height: 24,   // double
  //               ),
  //               onPressed: () {},
  //             ),
  //             IconButton(
  //               icon: Image.asset('varliklar/resimler/bag.png',
  //               width: 24,
  //               height: 24,
  //               ),
  //               onPressed: () {},
  //             ),
  //            // IconButton(
  //            //   icon: const Icon(Icons.shopping_cart),
  //            //   onPressed: () {},
  //            // ),
  //         ]
  //       ),
  //       body: Center(   // body, sayfanın gövde kısmını veriyor
  //         child: Text(
  //           'Hello, $name! How are you?',
  //         ),
  //       ),
  //       drawer: Drawer(),   // Scaffold da appBar ın soluna menü ekleme. Scaffold da appBar olduğu için appBar biliyorki bu menü ile açılacak
  //     ),
  //   );
  //
  //   runApp(myApp());

  runApp(const MyApp());
}

int pozitifSayiTopla(int a, int b) {
  // (int a, int b) => hepsi zorunlu ve sıralı
  // ([int a, int b]) => hepsi zorunlu değil ve sıralı
  // (int a, [int b=0]) => biri zorunlu biri zorunlu değil ve sıralı
  // ({int a, int b}) => ikiside zorunlu ve sırasız fakat parametre yollarken a:10 , b:5 şeklinde olmalı
  // ({int a=10, int b=5}) => ikiside zorunlu değil ve sırasız fakat parametre yollarken a:10 , b:5 şeklinde olmalı
  // ({required int a, int b=5}) => biri zorunlu biri zorunlu değil ve sırasız fakat parametre yollarken a:10 , b:5
  //  ({required int a, required int b}) => ikiside zorunlu ve sırasız fakat parametre yollarken a:10 , b:5 şeklinde olmalı
  if (a < 0 || b < 0) {
    throw Exception('a ve b pozitif sayı olmalıdır. a: $a  b:$b');
  }
  return a + b;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Kalan süre değişkeni
  late Duration _timeUntilTarget;
  //pageView conterller değişkeni
  final PageController controller = PageController(initialPage: 0);
  //pageView in bulunduğu sayfayı kontol için değişken
  int currentPage = 0;
  //slider noktaları
  late Color dot1 = const Color.fromRGBO(29, 78, 216, 1);
  late Color dot2 = Colors.grey;
  late Color dot3 = Colors.grey;
  late Color dot4 = Colors.grey;
  late Color dot5 = Colors.grey;
  //Slider otomatik kayması için sayaç
  int sayac = 0;

  @override
  void initState() {
    super.initState();

    //Hedef an
    DateTime targetDate = DateTime(2024, 1, 30, 11);
/*
    //Tekrar dedin sayaç(zamana bağlı işlemler için)
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int nextPage = (controller.page?.round() ?? 0) + 1;
        if (nextPage > 4) {
          nextPage = 0;
        }
        if (sayac == 8) {
          controller.animateToPage(nextPage,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
          sayac = 0;
        }
        sayac++;
        _timeUntilTarget = targetDate.difference(DateTime.now());
      });
    });
*/
    //Hedef ana kalan sürenin hesaplandığı yer
    _timeUntilTarget = targetDate.difference(DateTime.now());

    // Sayfa değiştiği andaki işlemler
    controller.addListener(() {
      setState(() {
        currentPage = controller.page?.round() ?? 0;
        switch (currentPage) {
          case 0:
            dot1 = const Color(0xFF1D4ED8);
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Colors.grey;
          case 1:
            dot1 = Colors.grey;
            dot2 = const Color(0xFF1D4ED8);
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = Colors.grey;
          case 2:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = const Color(0xFF1D4ED8);
            dot4 = Colors.grey;
            dot5 = Colors.grey;
          case 3:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = const Color(0xFF1D4ED8);
            dot5 = Colors.grey;
          case 4:
            dot1 = Colors.grey;
            dot2 = Colors.grey;
            dot3 = Colors.grey;
            dot4 = Colors.grey;
            dot5 = const Color(0xFF1D4ED8);
        }
      });
    });
  }

// class MyApp extends StatelessWidget {
//  const MyApp({super.key});

  @override // StatelessWidget clasındakileri override ediyor (getiriyor) .
  Widget build(BuildContext context) {
    // Context = bağlam
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Home"), centerTitle: false, actions: [
          IconButton(
            icon: Image.asset(
              'varliklar/resimler/notification.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              'varliklar/resimler/bag.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {},
          ),
        ]),
        body: SingleChildScrollView(
          child: Column(
            // Column : yukardan aşşağı elamanları dizmemizi sağlayan bir widget
            children: [
              // birden fazla eleman alacağı için liste notasyonu şeklinde children alıyor.
              const SizedBox(height: 24),
              // appBar dan sonra (home dan sonra) 24 piksel boşluk bırakır.
              const Padding(
                padding:
                    EdgeInsets.all(16.0), // her yerden 16 piksel boşluk braktık
                child: TextField(
                  //  const TextField(), : search bar oluşturur
                  decoration: InputDecoration(
                    labelText: "Search Anything...",
                    // Yazı yazmaya başladığımızda buradaki yazı yukarı kayar.
                    // hintText: "Search Anything...",    // Yazı yazmaya başladığımızda buradaki yazı kaybolur.
                    prefixIcon: Icon(Icons
                        .search), // Image.asset("varliklar/resimler/search.png",
                    //     height: 10,
                    //     width: 10 ),          // search ikonu ekledik
                    border: OutlineInputBorder(
                      // search barın tamamen çizgiler ile çevrelenmesini sağladık
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      //search barın köşeleri çeyrek daire şeklinde oldu
                      borderSide:
                          BorderSide(color: Color(0xFFD1D5DB), width: 1),
                      // 0x : hexa decimal  FF : hiç opasite yok tamamen opak // Colors.grey,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                // simetrik olarak sadece sağdan ve soldan 16 piksel
                child: Row(
                  // Row: satır
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0.11,
                        letterSpacing: 0.07,
                      ),
                    ),
                    Spacer(), // Bulduğu alanı dolduran bir boşluk ekler.
                    Text(
                      'View All ->',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.12,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                // kaydırma işlemi
                scrollDirection: Axis.horizontal, // yatay eksende kay.
                child: FutureBuilder(
                  // FutureBuilder da yapılan değişiklikler sayfayı yenileyince gösterilir.
                  future:
                      FirebaseFirestore.instance.collection('categories').get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      final categoryList =
                          snapshot.data!.docs.map((e) => e.data()).toList();
                      return Row(
                        children: [
                          const SizedBox(width: 6),
                          for (final data in categoryList)
                            CategoryWidget(
                              title: data['name'],
                              imageUrl: data['imageUrl'],
                            ),
                          const SizedBox(width: 6),
                          /*StreamBuilder(               // StreamBuilder yapılan değişikleri sayfayı yenilemeden görüntüler.
                          stream: FirebaseFirestore.instance     // Bu yüzden sürekli değişip değişmediğini kontrol etmek
                              .collection('categories')          // için internet yer.  Sürekli veri akışı olur,
                              .doc('cz4AbCCe1dPVPBupBxgI')       // sunucu trafiği oluşur.
                              .snapshots(),
                          /* Future.microtask(() async {
                            await Future.delayed(
                                const Duration(milliseconds: 2500));
                            return "Title";
                          },),*/
                          builder: (_, snapshot) {
                            // snapshot : future fonksiyonunun durumunu takip ediyor.
                            print(snapshot.data);
                            
                            if (snapshot.hasData) {
                              final data=snapshot.data!.data();
                              return CategoryWidget(
                                title: data==null ? 'Bulunamadı' : data['name'],
                                imageUrl: "",
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),*/
                          // const CategoryWidget(title: "title", imageUrl: ""),
                          /*Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Image.asset('varliklar/resimler/fashion.png'),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text("Fashion"),
                                ),

                                // for (int i = 0; i < 10; i++)
                                //   Column(
                                //     children: [
                                //       if (i % 2 == 0)
                                //         Image.asset('varliklar/resimler/fashion.png')
                                //       else
                                //         Image.asset('varliklar/resimler/electronics.png'),
                                //       Text(i % 2 == 0 ? "Fashion" : "Electronics"),
                              ],
                            ),
                          ),*/
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              // Slider
              Container(
                width: 360,
                height: 154,
                child: PageView(
                  controller: controller,
                  children: <Widget>[
                    Center(
                      child: Image.asset("varliklar/resimler/slider1.png"),
                    ),
                    Center(
                      child: Image.asset("varliklar/resimler/slider2.jpg"),
                    ),
                    Center(
                      child: Image.asset("varliklar/resimler/slider3.jpg"),
                    ),
                    Center(
                      child: Image.asset("varliklar/resimler/slider4.jpg"),
                    ),
                    Center(
                      child: Image.asset("varliklar/resimler/slider5.jpg"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: dot1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: dot2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: dot3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: dot4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: dot5,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              //Deal of the day + Sayaç + Özel indirimler
              Container(
                color: const Color(0xFFF6F6F6),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        child: Row(
                          children: [
                            Text(
                              "Deal of the day",
                              style: TextStyle(
                                color: Color(0xFF1F2937),
                                fontSize: 14,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                                height: 0.11,
                                letterSpacing: 0.07,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "View All ->",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 12,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 2),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFFEF4444),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "${_timeUntilTarget.inDays} DAY ${_timeUntilTarget.inHours % 24} HRS ${_timeUntilTarget.inMinutes % 60} MIN ${_timeUntilTarget.inSeconds % 60} SEC",
                                  textAlign: TextAlign.center,
                                  style:
                                      const TextStyle(color: Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFFFFFFF),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                              "varliklar/resimler/running.png"),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Running Shoes"),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color(0xFFEF4444),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                "Upto 40% OFF",
                                                style: TextStyle(
                                                    color: Color(0xFFFFFFFF)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Image.asset(
                                              "varliklar/resimler/sneakers.png"),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Sneakers"),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color(0xFFEF4444),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                "40-60% OFF",
                                                style: TextStyle(
                                                    color: Color(0xFFFFFFFF)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                                "varliklar/resimler/wrist.png"),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Wrist Watches"),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color(0xFFEF4444),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Upto 40% OFF",
                                                  style: TextStyle(
                                                      color: Color(0xFFFFFFFF)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            Image.asset(
                                                "varliklar/resimler/speaker.png"),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Bluetooth Speakers"),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color(0xFFEF4444),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Text(
                                                  "40-60% OFF",
                                                  style: TextStyle(
                                                      color: Color(0xFFFFFFFF)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //Hot Selling Footwear
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Hot Selling Footwear",
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 14,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        height: 0.11,
                        letterSpacing: 0.07,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "View All ->",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        height: 0.12,
                      ),
                    )
                  ],
                ),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: AnasayfaUrunWidget(
                      resimAdresi: "varliklar/resimler/adidas1.png",
                      baslik: "Adidas white sneakers for men",
                      usdFiyat: 68,
                      indirimOrani: 50,
                      favorideMi: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: AnasayfaUrunWidget(
                      resimAdresi: "varliklar/resimler/nike1.png",
                      baslik: "Nike black running shoes for men",
                      usdFiyat: 75,
                      indirimOrani: 20,
                      favorideMi: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: AnasayfaUrunWidget(
                      resimAdresi: "varliklar/resimler/nikeSky2.png",
                      baslik: "Nike sky blue & white Sneakers",
                      usdFiyat: 137,
                      indirimOrani: 25,
                      favorideMi: true,
                    ),
                  )
                ]),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items:const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.amber[800],
        //   onTap:

        // ),
        
        drawer: const Drawer(),
      ),
    );
  }
}

String selamlamaMetni = "Merhaba Arkadaşlar!";

// String selamlamaMetni='Merhaba Arkadaşlar!';    bu kod da olur

int sayi = 5;

String isim = "Serbay";
String soyisim = "Özkan";

int yas = 22;

double kilo = 70.45;

bool askerlikYaptiMi = false;

List<int> okullaGecenYillar = [2013, 2014, 2015, 2016, 2017, 29018, 2019];
// <> =>jenerik <int> => listenin içindeki elemanların hepsinin veri tipi int olacak.
// List => Listelerin elemanları jenerik kullanılmaz ise istenilen veri türleri aynı listede kullanılabilir.
// Örenğin, string veri türü ile int veri türü aynı listede kullanılabilir.

Insan serbay = Insan("Serbay", "Özkan", 22, 70.45, false,
    [2013, 2014, 2015, 2016, 2017, 29018, 2019]);

Ogrenci tuncay = Ogrenci(
    "Tuncay",
    "Özkan",
    22,
    70.45,
    false,
    [2013, 2014, 2015, 2016, 2017, 29018, 2019],
    "123456",
    "Süleyman Demirel Üniversitesi");

class Insan {
  // İnsan isminde bir kavram oluşturduk.
  String isim;
  String soyisim;
  int yas;
  double kilo;
  bool askerlikYaptiMi;
  List<int> okullaGecenYillar;

// Oluşturucu fonksiyon (constructor)
  Insan(this.isim, this.soyisim, this.yas, this.kilo, this.askerlikYaptiMi,
      this.okullaGecenYillar) {
    // İnsan kavramı oluşabilmesi
    // için Constructor a parametre olarak insan kavramı oluşabilmesi için gereken özellikleri verdik.
    print("İnsan sınıfı oluşturuldu.");
  }
  int dogumYiliniHesapla() {
    DateTime simdi = DateTime
        .now(); // now() metodu isimlendirilmiş oluşturucu metottur. Yani named constructor.
    return simdi.year - yas;
  }
}

class Ogrenci extends Insan {
  String okulNumara;
  String okulIsmi;

  Ogrenci(
      super.isim,
      super.soyisim,
      super.yas,
      super.kilo,
      super.askerlikYaptiMi,
      super.okullaGecenYillar,
      this.okulNumara,
      this.okulIsmi) {
    // super => kavramı ben üst sınıfta tanımladım demek.
    print("Öğrenci sınıfı oluşturuldu.");
  }
  @override
  int dogumYiliniHesapla() {
    return 2002;
  }
}
