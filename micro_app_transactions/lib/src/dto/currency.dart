part of '../domain/entities/currency.dart';

extension CurrencyDTO on CurrencyEntity {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currency': currency,
      'value': value,
    };
  }

  static CurrencyEntity fromMap(Map<String, dynamic> map) {
    return CurrencyEntity(
      currency: map['currency'] as String,
      value: map['value'] as num,
    );
  }
}