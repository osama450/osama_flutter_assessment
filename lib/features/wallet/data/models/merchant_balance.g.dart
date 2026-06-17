// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantBalance _$MerchantBalanceFromJson(Map<String, dynamic> json) =>
    MerchantBalance(
      merchantId: json['merchant_id'] as String,
      merchantName: json['merchant_name'] as String,
      merchantLogo: json['merchant_logo'] as String,
      points: (json['points'] as num).toInt(),
      tier: json['tier'] as String,
    );

Map<String, dynamic> _$MerchantBalanceToJson(MerchantBalance instance) =>
    <String, dynamic>{
      'merchant_id': instance.merchantId,
      'merchant_name': instance.merchantName,
      'merchant_logo': instance.merchantLogo,
      'points': instance.points,
      'tier': instance.tier,
    };
