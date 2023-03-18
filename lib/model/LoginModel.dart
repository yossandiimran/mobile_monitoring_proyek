// ignore_for_file: unnecessary_this, file_names

part of '../header.dart';

class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;
  User? user;

  Data({this.accessToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? username;
  String? nrp;
  String? pSite;
  String? plant;
  String? hakAkses;
  List<String>? permission;
  Setting? setting;

  User(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.nrp,
      this.pSite,
      this.plant,
      this.hakAkses,
      this.permission,
      this.setting});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    nrp = json['nrp'];
    pSite = json['p_site'];
    plant = json['plant'];
    hakAkses = json['hak_akses'];
    permission = json['permission'].cast<String>();
    setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['nrp'] = this.nrp;
    data['p_site'] = this.pSite;
    data['plant'] = this.plant;
    data['hak_akses'] = this.hakAkses;
    data['permission'] = this.permission;
    if (this.setting != null) {
      data['setting'] = this.setting!.toJson();
    }
    return data;
  }
}

class Setting {
  String? urlsap;
  String? ashost;
  String? sysnr;
  String? client;
  String? usap;
  String? psap;

  Setting({this.urlsap, this.ashost, this.sysnr, this.client, this.usap, this.psap});

  Setting.fromJson(Map<String, dynamic> json) {
    urlsap = json['urlsap'];
    ashost = json['ashost'];
    sysnr = json['sysnr'];
    client = json['client'];
    usap = json['usap'];
    psap = json['psap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['urlsap'] = this.urlsap;
    data['ashost'] = this.ashost;
    data['sysnr'] = this.sysnr;
    data['client'] = this.client;
    data['usap'] = this.usap;
    data['psap'] = this.psap;
    return data;
  }
}
