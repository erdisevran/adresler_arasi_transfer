
class Kullanici_bilgileri {

  String KULLANICI_ID;
  String KULLANICI_AD;
  String AD;
  String SOYAD;
  String EPOSTA;
  String CIHAZ_ID;
  String TOKEN;
  String MULTI_AUTH;
  String SESSION_ID;
  String SIFRE;
  String VERSION;

	Kullanici_bilgileri.fromJsonMap(Map<String, dynamic> map):
		KULLANICI_ID = map["KULLANICI_ID"],
		KULLANICI_AD = map["KULLANICI_AD"],
		AD = map["AD"],
		SOYAD = map["SOYAD"],
		EPOSTA = map["EPOSTA"],
		CIHAZ_ID = map["CIHAZ_ID"],
		TOKEN = map["TOKEN"],
		MULTI_AUTH = map["MULTI_AUTH"],
		SESSION_ID = map["SESSION_ID"],
		SIFRE = map["SIFRE"],
		VERSION = map["VERSION"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['KULLANICI_ID'] = KULLANICI_ID;
		data['KULLANICI_AD'] = KULLANICI_AD;
		data['AD'] = AD;
		data['SOYAD'] = SOYAD;
		data['EPOSTA'] = EPOSTA;
		data['CIHAZ_ID'] = CIHAZ_ID;
		data['TOKEN'] = TOKEN;
		data['MULTI_AUTH'] = MULTI_AUTH;
		data['SESSION_ID'] = SESSION_ID;
		data['SIFRE'] = SIFRE;
		data['VERSION'] = VERSION;
		return data;
	}
}
