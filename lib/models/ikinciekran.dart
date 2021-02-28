
class Ikinciekran {

  String MALZ_NO;
  String MALZ_METNI;
  int MIKTAR;
  int TMIKTAR;
  String HEDEF_ADRES;
  List<Object> ONERILEN_ADRESLER;
  String MIKTAR_YETKI;

	Ikinciekran.fromJsonMap(Map<String, dynamic> map):
		MALZ_NO = map["MALZ_NO"],
		MALZ_METNI = map["MALZ_METNI"],
		MIKTAR = map["MIKTAR"],
		TMIKTAR = map["TMIKTAR"],
		HEDEF_ADRES = map["HEDEF_ADRES"],
		ONERILEN_ADRESLER = map["ONERILEN_ADRESLER"],
		MIKTAR_YETKI = map["MIKTAR_YETKI"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['MALZ_NO'] = MALZ_NO;
		data['MALZ_METNI'] = MALZ_METNI;
		data['MIKTAR'] = MIKTAR;
		data['TMIKTAR'] = TMIKTAR;
		data['HEDEF_ADRES'] = HEDEF_ADRES;
		data['ONERILEN_ADRESLER'] = ONERILEN_ADRESLER;
		data['MIKTAR_YETKI'] = MIKTAR_YETKI;
		return data;
	}
}
