// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:petro_one/features/auth/domin/user.dart';

class UserModel extends User {
  const UserModel({
    super.uid,
    super.name,
    super.email,
    super.lang,
    super.password,
    super.createAtEN,
    super.countryCode,
    super.createAtAR,
    super.isActive,
    super.phone,
    super.points,
    super.profitsSoFar,
    super.profits,
    super.accountType,
    super.rate,
    super.numOfVideos,
    super.numOfImg,
    super.numOfGif,
    super.numOfCards,
    super.id,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? numOfCards,
    String? email,
    String? countryCode,
    String? lang,
    String? password,
    String? createAtEN,
    String? createAtAR,
    bool? isActive,
    String? phone,
    int? points,
    int? profitsSoFar,
    int? profits,
    String? accountType,
    String? rate,
    String? numOfVideos,
    String? numOfImg,
    String? numOfGif,
    String? id,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      lang: lang ?? this.lang,
      numOfCards: numOfCards ?? this.numOfCards,
      password: password ?? this.password,
      createAtEN: createAtEN ?? this.createAtEN,
      createAtAR: createAtAR ?? this.createAtAR,
      isActive: isActive ?? this.isActive,
      phone: phone ?? this.phone,
      points: points ?? this.points,
      profitsSoFar: profitsSoFar ?? profitsSoFar,
      profits: profits ?? profits,
      accountType: accountType ?? this.accountType,
      rate: rate ?? this.rate,
      numOfVideos: numOfVideos ?? this.numOfVideos,
      numOfImg: numOfImg ?? this.numOfImg,
      numOfGif: numOfGif ?? this.numOfGif,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (uid != null) 'uid': uid,
      if (lang != null) 'lang': lang,
      if (countryCode != null) 'countryCode': countryCode,
      if (numOfCards != null) 'numOfCards': numOfCards,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (createAtEN != null) 'createAtEN': createAtEN,
      if (createAtAR != null) 'createAtAR': createAtAR,
      if (isActive != null) 'isActive': isActive,
      if (phone != null) 'phone': phone,
      if (points != null) 'points': points,
      if (profitsSoFar != null) 'profitsSoFar': profitsSoFar,
      if (profits != null) 'profits': profits,
      if (accountType != null) 'accountType': accountType,
      if (rate != null) 'rate': rate,
      if (numOfVideos != null) 'numOfVideos': numOfVideos,
      if (numOfImg != null) 'numOfImg': numOfImg,
      if (numOfGif != null) 'numOfGif': numOfGif,
      if (id != null) 'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      countryCode:
          map['countryCode'] != null ? map['countryCode'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      lang: map['lang'] != null ? map['lang'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      createAtEN:
          map['createAtEN'] != null ? map['createAtEN'] as String : null,
      createAtAR:
          map['createAtAR'] != null ? map['createAtAR'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      points: map['points'] != null ? map['points'] as int : null,
      numOfCards:
          map['numOfCards'] != null ? map['numOfCards'] as String : null,
      profitsSoFar:
          map['profitsSoFar'] != null ? map['profitsSoFar'] as int : null,
      profits: map['profits'] != null ? map['profits'] as int : null,
      accountType:
          map['accountType'] != null ? map['accountType'] as String : null,
      rate: map['rate'] != null ? map['rate'] as String : null,
      numOfVideos:
          map['numOfVideos'] != null ? map['numOfVideos'] as String : null,
      numOfImg: map['numOfImg'] != null ? map['numOfImg'] as String : null,
      numOfGif: map['numOfGif'] != null ? map['numOfGif'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, password: $password, createAt: $createAtEN, isActive: $isActive, phone: $phone, points: $points, profitsSoFar: $profitsSoFar, accountType: $accountType, rate: $rate, numOfVideos: $numOfVideos, numOfImg: $numOfImg, numOfGif: $numOfGif, id: $id)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.countryCode == countryCode &&
        other.email == email &&
        other.numOfCards == numOfCards &&
        other.lang == lang &&
        other.profits == profits &&
        other.password == password &&
        other.createAtEN == createAtEN &&
        other.createAtAR == createAtAR &&
        other.isActive == isActive &&
        other.phone == phone &&
        other.points == points &&
        other.profitsSoFar == profitsSoFar &&
        other.accountType == accountType &&
        other.rate == rate &&
        other.numOfVideos == numOfVideos &&
        other.numOfImg == numOfImg &&
        other.numOfGif == numOfGif &&
        other.id == id;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        createAtEN.hashCode ^
        createAtAR.hashCode ^
        isActive.hashCode ^
        numOfCards.hashCode ^
        phone.hashCode ^
        countryCode.hashCode ^
        profits.hashCode ^
        points.hashCode ^
        lang.hashCode ^
        profitsSoFar.hashCode ^
        accountType.hashCode ^
        rate.hashCode ^
        numOfVideos.hashCode ^
        numOfImg.hashCode ^
        numOfGif.hashCode ^
        id.hashCode;
  }
}
