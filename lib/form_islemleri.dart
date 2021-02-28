import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transfer/remote_api.dart';
import 'package:http/http.dart' as http;
import 'models/Gonderi.dart';

class FormIslemleri extends StatefulWidget {
  @override
  _FormIslemleriState createState() => _FormIslemleriState();
}

class _FormIslemleriState extends State<FormIslemleri> {
  String girilenMetin;
  final userControl = TextEditingController(text: "ERDIS");
  final passControl = TextEditingController(text: "123");
  String user;
  String pass;
  String islem;
  String mesaj;
  Future<Gonderi> futureAlbum;
  Gonderi gonderi;

  @override
  void dispose() {
    userControl.dispose();
    passControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        //padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: userControl,
                  textInputAction: TextInputAction.go,
                  //go
                  onSubmitted: (String s) {
                    // debugPrint("on submit: $s" + userControl.text.toString());
                    (girilenMetin = s);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Kullanıcı Adınız",
                      labelText: "Kullanıcı",
                      icon: Icon(Icons.verified_user),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passControl,
                  //textInputAction: TextInputAction.send,
                  //autofocus: true,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Kullanıcı Şifresi",
                      labelText: "Şifre",
                      icon: Icon(Icons.security),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  padding: EdgeInsets.all(15),
                  color: Colors.blue[900],
                  onPressed: () {
                    futureAlbum = fetchAlbum(userControl.text.toString(),
                            passControl.text.toString())
                        .then((_) {
                      if (islem.toString() == "1") {
                        //debugPrint("sonuc 1");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RemoteApiKullanimi(
                                    userControl.text.toString(),
                                    passControl.text.toString())));
                      } else {
                        //print("mesaj: " + mesaj.toString());
                      }
                    });
                  },
                  child: Text(
                    "Giriş verileri gönder",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Gonderi> fetchAlbum(String user, String pass) async {
    final response = await http.get(
      //'http://sapr3-test.hepsiburada.dmz:8000/sap(bD10ciZjPTIwMA==)/bc/bsp/sap/zwm_bsp_013/request.html?process_type=01&json_request={ "KULLANICI_BILGILERI":{ "KULLANICI_ID":"", "KULLANICI_AD":"$user", "AD":"", "SOYAD":"", "EPOSTA":"", "CIHAZ_ID":"", "TOKEN":"", "MULTI_AUTH":"", "SESSION_ID":"", "SIFRE":"$pass", "VERSION":""}, "SONUC":{ "ISLEM_DURUMU":0 , "MESAJ_TIPI":"", "MSGID":"", "MSGNO":"", "MESAJ":"", "MSGGROUP":""}, "ILKEKRAN":{ "BARKODLAR":[ ], "KAYNAKDEPO":"", "BARKOD":""}, "IKINCIEKRAN":{ "MALZ_NO":"", "MALZ_METNI":"", "MIKTAR":0 , "TMIKTAR":0 , "HEDEF_ADRES":"", "ONERILEN_ADRESLER":[ ], "MIKTAR_YETKI":""}}');
      //'http://sapr3-test.hepsiburada.dmz:8000/sap/bc/bsp/sap/zwm_bsp_013/request.html?process_type=01&json_request={ "KULLANICI_BILGILERI":{ "KULLANICI_ID":"", "KULLANICI_AD":"$user", "AD":"", "SOYAD":"", "EPOSTA":"", "CIHAZ_ID":"", "TOKEN":"", "MULTI_AUTH":"", "SESSION_ID":"", "SIFRE":"$pass", "VERSION":""}, "SONUC":{ "ISLEM_DURUMU":0 , "MESAJ_TIPI":"", "MSGID":"", "MSGNO":"", "MESAJ":"", "MSGGROUP":""}, "ILKEKRAN":{ "BARKODLAR":[ ], "KAYNAKDEPO":"", "BARKOD":""}, "IKINCIEKRAN":{ "MALZ_NO":"", "MALZ_METNI":"", "MIKTAR":0 , "TMIKTAR":0 , "HEDEF_ADRES":"", "ONERILEN_ADRESLER":[ ], "MIKTAR_YETKI":""}}',
      'http://qa-app-02.hepsiburada.dmz:8000/sap/bc/bsp/sap/zwm_bsp_013/request.html?process_type=01&json_request={ "KULLANICI_BILGILERI":{ "KULLANICI_ID":"", "KULLANICI_AD":"$user", "AD":"", "SOYAD":"", "EPOSTA":"", "CIHAZ_ID":"", "TOKEN":"", "MULTI_AUTH":"", "SESSION_ID":"", "SIFRE":"$pass", "VERSION":""}, "SONUC":{ "ISLEM_DURUMU":0 , "MESAJ_TIPI":"", "MSGID":"", "MSGNO":"", "MESAJ":"", "MSGGROUP":""}, "ILKEKRAN":{ "BARKODLAR":[ ], "KAYNAKDEPO":"", "BARKOD":""}, "IKINCIEKRAN":{ "MALZ_NO":"", "MALZ_METNI":"", "MIKTAR":0 , "TMIKTAR":0 , "HEDEF_ADRES":"", "ONERILEN_ADRESLER":[ ], "MIKTAR_YETKI":""}}',
    );
    //print('I was waiting here :)');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      gonderi = Gonderi.fromJsonMap(data);
      islem = gonderi.sonuc.islem_durumu.toString();
      mesaj = gonderi.sonuc.mesaj.toString();
      return Gonderi.fromJsonMap(json.decode(response.body));
    } else {
      //debugPrint("fetchalb3");
      throw Exception('Failed to load album');
    }
  }
}
