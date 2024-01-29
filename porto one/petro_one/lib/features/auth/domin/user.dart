// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? password;
  final String? createAtEN;
  final String? createAtAR;
  final bool? isActive;
  final String? phone;
  final String? countryCode;
  final int? points;
  final int? profitsSoFar;
  final int? profits;
  final String? accountType;
  final String? rate;
  final String? numOfVideos;
  final String? numOfImg;
  final String? numOfGif;
  final String? numOfCards;
  final String? id;
  final String? lang;
  const User({
    required this.countryCode,
    required this.numOfCards,
    required this.uid,
    required this.profits,
    required this.name,
    required this.email,
    required this.password,
    required this.createAtEN,
    required this.createAtAR,
    required this.isActive,
    required this.phone,
    required this.points,
    required this.profitsSoFar,
    required this.accountType,
    required this.rate,
    required this.numOfVideos,
    required this.numOfImg,
    required this.numOfGif,
    required this.id,
    required this.lang,
  });
  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        countryCode,
        password,
        createAtEN,
        isActive,
        phone,
        points,
        profitsSoFar,
        accountType,
        createAtAR,
        rate,
        numOfVideos,
        numOfImg,
        profits,
        lang,
        numOfGif,
        id,
      ];
}
