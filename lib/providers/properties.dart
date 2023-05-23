// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class Properties {
  final String version;
  final bool isOnline;
  final bool isLoading;
  final bool isAutorized;
  final bool haveCredentials;

  const Properties({
    required this.version,
    required this.isOnline,
    required this.isLoading,
    required this.isAutorized,
    required this.haveCredentials,
  });

  Properties copyWith({
    String? version,
    bool? isOnline,
    bool? isLoading,
    bool? isAutorized,
    bool? haveCredentials,
  }) {
    return Properties(
      version: version ?? this.version,
      isOnline: isOnline ?? this.isOnline,
      isLoading: isLoading ?? this.isLoading,
      isAutorized: isAutorized ?? this.isAutorized,
      haveCredentials: haveCredentials ?? this.haveCredentials,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'isOnline': isOnline,
      'isLoading': isLoading,
      'isAutorized': isAutorized,
      'haveCredentials': haveCredentials,
    };
  }

  factory Properties.fromMap(Map<String, dynamic> map) {
    return Properties(
      version: map['version'] as String,
      isOnline: map['isOnline'] as bool,
      isLoading: map['isLoading'] as bool,
      isAutorized: map['isAutorized'] as bool,
      haveCredentials: map['haveCredentials'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Properties.fromJson(String source) =>
      Properties.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Properties(version: $version, isOnline: $isOnline, isLoading: $isLoading, isAutorized: $isAutorized, haveCredentials: $haveCredentials)';
  }

  @override
  bool operator ==(covariant Properties other) {
    if (identical(this, other)) return true;

    return other.version == version &&
        other.isOnline == isOnline &&
        other.isLoading == isLoading &&
        other.isAutorized == isAutorized &&
        other.haveCredentials == haveCredentials;
  }

  @override
  int get hashCode {
    return version.hashCode ^
        isOnline.hashCode ^
        isLoading.hashCode ^
        isAutorized.hashCode ^
        haveCredentials.hashCode;
  }
}

class PropertiesNotifier extends StateNotifier<Properties> {
  PropertiesNotifier(super.state);

  void setIsOnline(bool value) {
    state = state.copyWith(isOnline: value);
  }

  void setIsLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setVersion(String value) {
    state = state.copyWith(version: value);
  }

  void setIsAutorized(bool value) {
    state = state.copyWith(isAutorized: value);
  }

  void setHaveCredentials(bool value) {
    state = state.copyWith(haveCredentials: value);
  }
}
