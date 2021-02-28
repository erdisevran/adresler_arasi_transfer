import 'package:transfer/navigasyon_islemleri.dart';
import 'package:flutter/material.dart';
import 'package:transfer/remote_api.dart';
import 'form_islemleri.dart';

void main() {
  runApp(MaterialApp(
    title: "Transfer Çalışması",
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      '/': (context) => NavigasyonIslemleri(), // GET PACKAGE
      '/formIslemleri': (context) => FormIslemleri(),
      '/remoteApi': (context) => RemoteApiKullanimi("", ""),
    },
  ));
}
