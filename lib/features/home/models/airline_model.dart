import 'package:equatable/equatable.dart';

class AirLineModel extends Equatable {
  final String? site;
  final String? code;
  final String? alliance;
  final String? phone;
  final String? name;
  final String? usName;
  final String? clazz;
  final String? defaultName;
  final String? logoURL;
  bool? isFavourite;

  AirLineModel({
    this.site,
    this.code,
    this.alliance,
    this.phone,
    this.name,
    this.usName,
    this.clazz,
    this.defaultName,
    this.logoURL,
    this.isFavourite,
  });

  AirLineModel.fromJson(Map<String, dynamic> json)
      : site = json['site'] as String?,
        code = json['code'] as String?,
        alliance = json['alliance'] as String?,
        phone = json['phone'] as String?,
        name = json['name'] as String?,
        usName = json['usName'] as String?,
        clazz = json['__clazz'] as String?,
        defaultName = json['defaultName'] as String?,
        logoURL = json['logoURL'] as String?,
        isFavourite = false;

  Map<String, dynamic> toJson() => {
        'site': site,
        'code': code,
        'alliance': alliance,
        'phone': phone,
        'name': name,
        'usName': usName,
        '__clazz': clazz,
        'defaultName': defaultName,
        'logoURL': logoURL
      };

  @override
  List<Object?> get props => [
        site,
        code,
        alliance,
        phone,
        name,
        usName,
        clazz,
        defaultName,
        logoURL,
        isFavourite,
      ];
}
