// ignore_for_file: file_names

class TempTransaksiDBModel {
  String id = "";
  String noPoSto = "";
  String foto = "";
  String keterangan = "";
  String statusKirim = "";
  String createdAt = "";
  String sendAt = "";

  TempTransaksiDBModel(
    this.id,
    this.noPoSto,
    this.foto,
    this.keterangan,
    this.statusKirim,
    this.createdAt,
    this.sendAt,
  );

  TempTransaksiDBModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    noPoSto = map['no_po_sto'];
    foto = map['foto'];
    keterangan = map['keterangan'];
    statusKirim = map['status_kirim'];
    createdAt = map['created_at'];
    sendAt = map['send_at'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'no_po_sto': noPoSto,
      'foto': foto,
      'keterangan': keterangan,
      'status_kirim': statusKirim,
      'created_at': createdAt,
      'send_at': sendAt,
    };
  }

  @override
  String toString() {
    return 'Tagihan{id: $id, no_po_sto: $noPoSto, foto: $foto, keterangan: $keterangan,  status_kirim: $statusKirim, created_at: $createdAt, send_at: $sendAt}';
  }
}
