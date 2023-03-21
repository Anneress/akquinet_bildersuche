// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:akquinet_bildersuche/feature/bildersuche/models/pixabay_bild.dart';

// Ergebnis der Bildersuche mit Anzahl Ergebnisse für Pagination
class PixabayBildersucheResponse {
  final int anzahlErgebnisse;
  final int anzahlVerfuegbarerErgebnisse;
  final List<PixabayBild> bilder;

  PixabayBildersucheResponse({
    required this.anzahlErgebnisse,
    required this.anzahlVerfuegbarerErgebnisse,
    required this.bilder,
  });

  PixabayBildersucheResponse copyWith({
    int? anzahlErgebnisse,
    int? anzahlVerfuegbarerErgebnisse,
    List<PixabayBild>? bilder,
  }) {
    return PixabayBildersucheResponse(
      anzahlErgebnisse: anzahlErgebnisse ?? this.anzahlErgebnisse,
      anzahlVerfuegbarerErgebnisse:
          anzahlVerfuegbarerErgebnisse ?? this.anzahlVerfuegbarerErgebnisse,
      bilder: bilder ?? this.bilder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'anzahlErgebnisse': anzahlErgebnisse,
      'verfuegbareAnzahlErgebnisse': anzahlVerfuegbarerErgebnisse,
      'bilder': bilder.map((x) => x.toMap()).toList(),
    };
  }

  factory PixabayBildersucheResponse.fromMap(Map<String, dynamic> map) {
    return PixabayBildersucheResponse(
      anzahlErgebnisse: map['total'] as int,
      anzahlVerfuegbarerErgebnisse: map['totalHits'] as int,
      bilder: List<PixabayBild>.from(
        (map['hits'] as List<dynamic>).map<PixabayBild>(
          (x) => PixabayBild.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PixabayBildersucheResponse.fromJson(String source) =>
      PixabayBildersucheResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PixabayBildersucheResponse(anzahlErgebnisse: $anzahlErgebnisse, verfuegbareAnzahlErgebnisse: $anzahlVerfuegbarerErgebnisse, bilder: $bilder)';

  @override
  bool operator ==(covariant PixabayBildersucheResponse other) {
    if (identical(this, other)) return true;

    return other.anzahlErgebnisse == anzahlErgebnisse &&
        other.anzahlVerfuegbarerErgebnisse == anzahlVerfuegbarerErgebnisse &&
        listEquals(other.bilder, bilder);
  }

  @override
  int get hashCode =>
      anzahlErgebnisse.hashCode ^
      anzahlVerfuegbarerErgebnisse.hashCode ^
      bilder.hashCode;
}
