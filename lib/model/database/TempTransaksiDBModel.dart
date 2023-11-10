// ignore_for_file: file_names

class TempTransaksiDBModel {
  String plant = "";
  String noMobil = "";
  String noPo = "";
  String detail = "";
  String foto = "";
  String keterangan = "";
  String lat = "";
  String lng = "";
  String statusKirim = "";
  String isDone = "";
  String createdAt = "";
  String noDoc = "";

  TempTransaksiDBModel(
    this.plant,
    this.noMobil,
    this.noPo,
    this.detail,
    this.foto,
    this.keterangan,
    this.lat,
    this.lng,
    this.statusKirim,
    this.isDone,
    this.createdAt,
    this.noDoc,
  );

  TempTransaksiDBModel.fromMap(Map<String, dynamic> map) {
    plant = map["plant"];
    noMobil = map["no_mobil"];
    noPo = map["no_po"];
    detail = map["detail"];
    foto = map["foto"];
    keterangan = map["keterangan"];
    lat = map["lat"];
    lng = map["lng"];
    statusKirim = map["status_kirim"];
    isDone = map["is_done"];
    createdAt = map["created_at"];
    noDoc = map["no_doc"];
  }

  Map<String, dynamic> toMap() {
    return {
      "plant": plant,
      "no_mobil": noMobil,
      "no_po": noPo,
      "detail": detail,
      "foto": foto,
      "keterangan": keterangan,
      "lat": lat,
      "lng": lng,
      "status_kirim": statusKirim,
      "is_done": isDone,
      "created_at": createdAt,
      "no_doc": noDoc,
    };
  }

  @override
  String toString() {
    return 'Tagihan{plant: $plant, no_mobil: $noMobil, no_po: $noPo, detail: $detail, foto: $foto, keterangan: $keterangan, lat: $lat, lng: $lng, status_kirim: $statusKirim, is_done: $isDone, created_at: $createdAt, no_doc: $noDoc}';
  }
}
