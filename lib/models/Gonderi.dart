import 'ikinciekran.dart';
import 'ilkekran.dart';
import 'kullanicibilgileri.dart';
import 'sonuc.dart';

class Gonderi {
  Kullanici_bilgileri kullanici_bilgileri;
  Sonuc sonuc;
  Ilkekran ilkekran;
  Ikinciekran ikinciekran;

  Gonderi.fromJsonMap(Map<String, dynamic> map)
      : kullanici_bilgileri =
            Kullanici_bilgileri.fromJsonMap(map["KULLANICI_BILGILERI"]),
        sonuc = Sonuc.fromJsonMap(map["SONUC"]),
        ilkekran = Ilkekran.fromJsonMap(map["ILKEKRAN"]),
        ikinciekran = Ikinciekran.fromJsonMap(map["IKINCIEKRAN"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['KULLANICI_BILGILERI'] =
        kullanici_bilgileri == null ? null : kullanici_bilgileri.toJson();
    data['SONUC'] = sonuc == null ? null : sonuc.toJson();
    data['ILKEKRAN'] = ilkekran == null ? null : ilkekran.toJson();
    data['IKINCIEKRAN'] = ikinciekran == null ? null : ikinciekran.toJson();
    return data;
  }
}
