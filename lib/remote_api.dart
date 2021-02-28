import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transfer/detay_sayfasi.dart';
import 'package:transfer/form_islemleri.dart';
import 'models/Gonderi.dart';

class RemoteApiKullanimi extends StatefulWidget {
  String user_name;
  String password;

  RemoteApiKullanimi(String user, String pass) {
    user_name = user;
    password = pass;
  }

  @override
  _RemoteApiKullanimiState createState() =>
      _RemoteApiKullanimiState(user_name, password);
}

class _RemoteApiKullanimiState extends State<RemoteApiKullanimi> {
  String type;
  String sonuc_mesaj;
  String user;
  String pass;
  String barkod;
  String girilenKaynak;
  String islem;
  String mesaj;
  String malz_no;
  String miktar;
  String tmiktar;
  Gonderi gonderi;

  final kaynakControl = TextEditingController(text: "2-M01-08-0");
  final barkodControl = TextEditingController(text: "740617255751");
  final testcont = TextEditingController();
  final focus = FocusNode();

  _RemoteApiKullanimiState(String username, String password) {
    user = username;
    pass = password;
  }

  Future<Gonderi> fetchAlbum(String user, String pass, String kaynak) async {
    debugPrint("kaynak: " + kaynak.toString());
    final response = await http.get(
        //'http://sapr3-test.hepsiburada.dmz:8000/sap/bc/bsp/sap/zwm_bsp_013/request.html?process_type=02&json_request={ "KULLANICI_BILGILERI":{ "KULLANICI_ID":"", "KULLANICI_AD":"$user", "AD":"", "SOYAD":"", "EPOSTA":"", "CIHAZ_ID":"", "TOKEN":"", "MULTI_AUTH":"", "SESSION_ID":"", "SIFRE":"$pass", "VERSION":""}, "SONUC":{ "ISLEM_DURUMU":0 , "MESAJ_TIPI":"", "MSGID":"", "MSGNO":"", "MESAJ":"", "MSGGROUP":""}, "ILKEKRAN":{ "BARKODLAR":[ ], "KAYNAKDEPO":"$kaynak", "BARKOD":""}, "IKINCIEKRAN":{ "MALZ_NO":"", "MALZ_METNI":"", "MIKTAR":0 , "TMIKTAR":0 , "HEDEF_ADRES":"", "ONERILEN_ADRESLER":[ ], "MIKTAR_YETKI":""}}');
        'http://qa-app-02.hepsiburada.dmz:8000/sap/bc/bsp/sap/zwm_bsp_013/request.html?process_type=$type&json_request={ "KULLANICI_BILGILERI":{ "KULLANICI_ID":"", "KULLANICI_AD":"$user", "AD":"", "SOYAD":"", "EPOSTA":"", "CIHAZ_ID":"", "TOKEN":"", "MULTI_AUTH":"", "SESSION_ID":"", "SIFRE":"$pass", "VERSION":""}, "SONUC":{ "ISLEM_DURUMU":0 , "MESAJ_TIPI":"", "MSGID":"", "MSGNO":"", "MESAJ":"", "MSGGROUP":""}, "ILKEKRAN":{ "BARKODLAR":[ ], "KAYNAKDEPO":"$kaynak", "BARKOD":"$barkod"}, "IKINCIEKRAN":{ "MALZ_NO":"", "MALZ_METNI":"", "MIKTAR":0 , "TMIKTAR":0 , "HEDEF_ADRES":"", "ONERILEN_ADRESLER":[ ], "MIKTAR_YETKI":""}}');
    if (response.statusCode == 200) {
      debugPrint("donus: " + response.body.toString());
      var data = json.decode(response.body);
      gonderi = Gonderi.fromJsonMap(data);
      islem = gonderi.sonuc.islem_durumu.toString();
      mesaj = gonderi.sonuc.mesaj.toString();
      malz_no = gonderi.ikinciekran.MALZ_NO.toString();
      tmiktar = gonderi.ikinciekran.TMIKTAR.toString();
      miktar = gonderi.ikinciekran.MIKTAR.toString();
     // return Gonderi.fromJsonMap(json.decode(response.body));
      return Gonderi.fromJsonMap(data);
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
              textInputAction: TextInputAction.next,
              autofocus: true,
              onEditingComplete: () {
                debugPrint(
                    "onEditingComplete: " + kaynakControl.text.toString());
              },
              controller: kaynakControl,
              onSubmitted: (String s) {
                debugPrint("onSubmitted: " + kaynakControl.text.toString());

                type = '02';
                _futureAlbum =
                    fetchAlbum(user, pass, kaynakControl.text.toString())
                        .then((_) {
                  if (islem.toString() == "1") {
                    FocusScope.of(context).requestFocus(focus);
                    debugPrint("sonuc 1");
                  } else {
                    kaynakControl.clear();
                    print("mesaj: " + mesaj.toString());
                  }
                });
              },
              onChanged: (String s) {
                debugPrint("onChanged: $s");
              },
              decoration: InputDecoration(
                hintText: "Kaynak Depo",
                labelText: "Kaynak",
              ),
            ),
            TextField(
              focusNode: focus,
              controller: barkodControl,
              onSubmitted: (String s) {
                debugPrint("onSubmitted: " + barkodControl.text.toString());
                type = '03';
                barkod = barkodControl.text.toString();
                _futureAlbum =
                    fetchAlbum(user, pass, kaynakControl.text.toString())
                        .then((_) {
                  if (islem.toString() == "1") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetaySayfasi(
                                kaynakControl.text.toString(),
                                barkodControl.text.toString(),
                                malz_no.toString(),
                                miktar.toString(),
                                tmiktar.toString())));

                    debugPrint("sonuc 1" + barkodControl.text.toString());
                  } else {
                    barkodControl.clear();
                    print("mesaj: " + mesaj.toString());
                    FocusScope.of(context).requestFocus(focus);
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "Barkod Numarası",
                labelText: "Barkod",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
FutureBuilder<Gonderi>(
          future: _futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                sonuc_mesaj = snapshot.data.sonuc.islem_durumu.toString();
                if (sonuc_mesaj == "1") {
                  debugPrint("msj:" + snapshot.data.sonuc.mesaj);
                  return Text("Giriş Başarılı");
                } else {
                  Navigator.pop((context));
                  // return FormIslemleri();
                  // return Text("Başarısız");
                }
              } else if (snapshot.hasError) {
                debugPrint("${snapshot.error}");
                return Text("veri yok");
              }
            }
            return CircularProgressIndicator();
          },
        ),
 */
