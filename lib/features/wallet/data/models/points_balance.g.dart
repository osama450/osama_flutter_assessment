// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsBalance _$PointsBalanceFromJson(Map<String, dynamic> json) =>
    PointsBalance(
      totalPoints: (json['total_points'] as num).toInt(),
      pendingPoints: (json['pending_points'] as num).toInt(),
      expiringPoints: (json['expiring_points'] as num).toInt(),
      expiringDate: DateTime.parse(json['expiring_date'] as String),
      lastUpdated: DateTime.parse(json['last_updated'] as String),
      balancesByMerchant: (json['balances_by_merchant'] as List<dynamic>)
          .map((e) => MerchantBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PointsBalanceToJson(PointsBalance instance) =>
    <String, dynamic>{
      'total_points': instance.totalPoints,
      'pending_points': instance.pendingPoints,
      'expiring_points': instance.expiringPoints,
      'expiring_date': instance.expiringDate.toIso8601String(),
      'last_updated': instance.lastUpdated.toIso8601String(),
      'balances_by_merchant': instance.balancesByMerchant
          .map((e) => e.toJson())
          .toList(),
    };
