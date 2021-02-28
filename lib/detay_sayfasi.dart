import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/Gonderi.dart';

class DetaySayfasi extends StatefulWidget {
  String kaynakadres;
  String barkodno;
  String malzeme_no;
  String miktar;
  String tmiktar;

  DetaySayfasi(String kaynak, String barkod, String malz_no, String miktar,
      String tmiktar) {
    kaynakadres = kaynak;
    barkodno = barkod;
    malzeme_no = malz_no;
    this.miktar = miktar;
    this.tmiktar = tmiktar;
  }

  @override
  _DetaySayfasiState createState() =>
      _DetaySayfasiState(kaynakadres, barkodno, malzeme_no, miktar, tmiktar);
}

class _DetaySayfasiState extends State<DetaySayfasi> {
  String type;
  String islem;
  String mesaj;
  Gonderi gonderi;

  String kaynak;
  String barkod;
  String hedef;

  String malz_no;
  String miktar;

  String tmiktar;

  final hedefControl = TextEditingController(text: "2-E07-16-2");

  _DetaySayfasiState(String kaynakadres, String barkodno, String malzeme_no,
      String miktar, String tmiktar) {
    kaynak = kaynakadres;
    barkod = barkodno;
    malz_no = malzeme_no;
    this.miktar = miktar;
    this.tmiktar = tmiktar;
  }

  Future<Gonderi> fetchAlbum(String hedef) async {
    debugPrint("kaynak: " + kaynak.toString());
    final response = await http.get(
        //'http://sapr3-test.hepsiburada.dmz:8000/sap/bc/bsp/sap/zwm_bsp_013/request.html?process_type=02&json_request={ "KULLANICI_BILGILERI":{ "KULLANICI_ID":"", "KULLANICI_AD":"$user", "AD":"", "SOYAD":"", "EPOSTA":"", "CIHAZ_ID":"", "TOKEN":"", "MULTI_AUTH":"", "SESSION_ID":"", "SIFRE":"$pass", "VERSION":""}, "SONUC":{ "ISLEM_DURUMU":0 , "MESAJ_TIPI":"", "MSGID":"", "MSGNO":"", "MESAJ":"", "MSGGROUP":""}, "ILKEKRAN":{ "BARKODLAR":[ ], "KAYNAKDEPO":"$kaynak", "BARKOD":""}, "IKINCIEKRAN":{ "MALZ_NO":"", "MALZ_METNI":"", "MIKTAR":0 , "TMIKTAR":0 , "HEDEF_ADRES":"", "ONERILEN_ADRESLER":[ ], "MIKTAR_YETKI":""}}');
        'http://qa-app-02.hepsiburada.dmz:8000/sap/bc/bsp/sap/zwm_bsp_013/request.html?process_type=$type&json_request={ "KULLANICI_BILGILERI":{ "KULLANICI_ID":"", "KULLANICI_AD":"", "AD":"", "SOYAD":"", "EPOSTA":"", "CIHAZ_ID":"", "TOKEN":"", "MULTI_AUTH":"", "SESSION_ID":"", "SIFRE":"", "VERSION":""}, "SONUC":{ "ISLEM_DURUMU":0 , "MESAJ_TIPI":"", "MSGID":"", "MSGNO":"", "MESAJ":"", "MSGGROUP":""}, "ILKEKRAN":{ "BARKODLAR":[ ], "KAYNAKDEPO":"$kaynak", "BARKOD":"$barkod"}, "IKINCIEKRAN":{ "MALZ_NO":"$malz_no", "MALZ_METNI":"", "MIKTAR":$miktar , "TMIKTAR":$tmiktar , "HEDEF_ADRES":"$hedef", "ONERILEN_ADRESLER":[ ], "MIKTAR_YETKI":""}}');
    if (response.statusCode == 200) {
      debugPrint("donus: " + response.body.toString());
      var data = json.decode(response.body);
      gonderi = Gonderi.fromJsonMap(data);
      islem = gonderi.sonuc.islem_durumu.toString();
      mesaj = gonderi.sonuc.mesaj.toString();
      return Gonderi.fromJsonMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Gonderi> _futureAlbum;

  @override
  void initState() {
    debugPrint("giris init");
    // _futureAlbum = fetchAlbum();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Sayfası"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: hedefControl,
              onSubmitted: (String s) {
                debugPrint("onSubmitted: " + hedefControl.text.toString());
                type = '04';
                hedef = hedefControl.text.toString();
                debugPrint("_futureAlbum:" + hedefControl.text.toString());
                _futureAlbum =
                    fetchAlbum(hedefControl.text.toString()).then((_) {
                  if (islem.toString() == "1") {
                    debugPrint("sonuc 1" + hedefControl.text.toString());
                    print("mesaj: " + mesaj.toString());
                  } else {
                    hedefControl.clear();
                    print("mesaj: " + mesaj.toString());
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "Hedef Depo",
                labelText: "Hedef",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
