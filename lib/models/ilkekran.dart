
class Ilkekran {

  List<Object> BARKODLAR;
  String KAYNAKDEPO;
  String BARKOD;

	Ilkekran.fromJsonMap(Map<String, dynamic> map):
		BARKODLAR = map["BARKODLAR"],
		KAYNAKDEPO = map["KAYNAKDEPO"],
		BARKOD = map["BARKOD"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['BARKODLAR'] = BARKODLAR;
		data['KAYNAKDEPO'] = KAYNAKDEPO;
		data['BARKOD'] = BARKOD;
		return data;
	}
}
