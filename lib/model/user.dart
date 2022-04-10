import 'package:dumper/blocs/message_bloc.dart';
import 'package:flutter/material.dart';


class UserField {
  static const String lastMessageTime = 'lastMessageTime';
}

class User {
  final String idUser;
  final String name;
  final String urlAvatar;
  final DateTime lastMessageTime;

  const User({
    this.idUser,
    @required this.name,
    @required this.urlAvatar,
    @required this.lastMessageTime,
  });

  User copyWith({
    String idUser,
    String name,
    String urlAvatar,
    String lastMessageTime,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  static User fromJson(Map<String, dynamic> json) => User(
    idUser: json['idUser'],
    name: json['name'],
    urlAvatar: json['urlAvatar'],
    lastMessageTime: MessageBloc.toDateTime(json['lastMessageTime']),
  );

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'name': name,
    'urlAvatar': urlAvatar,
    'lastMessageTime': MessageBloc.fromDateTimeToJson(lastMessageTime),
  };
}