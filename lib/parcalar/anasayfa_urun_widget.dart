import 'package:flutter/material.dart';

class AnasayfaUrunWidget extends StatefulWidget {
  const AnasayfaUrunWidget(
      {super.key,
      required this.baslik,
      required this.resimAdresi,
      required this.usdFiyat,
      required this.indirimOrani,
      required this.favorideMi,
      }); // required: zorunlu , vermek zorunda

  final String baslik;
  final String resimAdresi;
  final double usdFiyat;
  final double indirimOrani;
  final bool favorideMi;

// İçi boş bırakılmış metotlara abstract metot denir.
// StatefulWidge da abstract metodu override edeceğiz.
  @override
  State createState() => _AnasayfaUrunWidgetState();
}
/*
  Üstteki fonksiyonun uzun versiyonu.
  State createState(){
   return _AnasayfaUrunWidgetState();
 } 
*/
// State döndürecek yani başka bir sınıf türünü döndürecek.


/* 
Örneğin Search Bar daki arama yerinde;
var _aranacakKelime=" ";

const String baslik="Adidas white sneakers for men";
const int usdFiyat=68;

final simdi=DateTime.now();
*/

/*  
Değişken işaretleyici:
var  : değişebilen değişkenlerde kullanılır.
final  : kodu yazarken ne olduğunu bilmediğimiz, değişmesini istemediğimiz, değişmeyen değişkenlerde kullanılır. 
const  : ne olduğunu bildiğimiz, değişmesini istemediğimiz, değişmeyen değişkenlerde kullanılır.
*/
/*
String baslik = "Adidas white sneakers for men";
String resimAdresi = "varliklar/resimler/adidas.png";
double usdFiyat = 68.5;
double indirimOrani = 50;
bool favorideMi = false;
*/
// access modifier(Erişim Belirleyicisi):  "_"=> private   State: durum
// State<AnasayfaUrunWidget>: Üsteki widget(AnasayfaUrunWidget) ın state i _AnasayfaUrunWidgetState dir demek.

class _AnasayfaUrunWidgetState extends State<AnasayfaUrunWidget> {
  Widget build(BuildContext context) {
    // Ekrana çizdirmek için build fonksiyonunu kullanıyoruz.
    // Placeholder(): Boş widgetleri döndürmek için kullanılabilir.
    return Card(  
      child: Column(
        children: [                                         // Stack 3.boyutu sağlar, yoğunluk oluşturur.
          Stack(children: [Image.asset(widget.resimAdresi), // Stack resmin üstüne birşeyler yazmamızı ve koymamızı sağlar.
          const Center(child: Icon(Icons.favorite)),
          // const Positioned.fill(child: Center(child: Icon(Icons.favorite))),  // kalbi resmin ortasına koyar
          ]),
          Text(widget.baslik),
          Row(
            children: [
              Text("\$${widget.usdFiyat}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const Text("\$136",
                  style: TextStyle(decoration: TextDecoration.lineThrough)),
              Text("${widget.indirimOrani}% OFF"),
            ],
          ),
        ],
      ),
    );
  }
}
