class Sonuc {
  int islem_durumu;
  String mesaj_tipi;
  String msgid;
  String msgno;
  String mesaj;
  String msggroup;

  Sonuc.fromJsonMap(Map<String, dynamic> map)
      : islem_durumu = map["ISLEM_DURUMU"],
        mesaj_tipi = map["MESAJ_TIPI"],
        msgid = map["MSGID"],
        msgno = map["MSGNO"],
        mesaj = map["MESAJ"],
        msggroup = map["MSGGROUP"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ISLEM_DURUMU'] = islem_durumu;
    data['MESAJ_TIPI'] = mesaj_tipi;
    data['MSGID'] = msgid;
    data['MSGNO'] = msgno;
    data['MESAJ'] = mesaj;
    data['MSGGROUP'] = msggroup;
    return data;
  }
}
