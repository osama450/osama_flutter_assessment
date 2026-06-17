import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'merchant_balance.dart';

part 'points_balance.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PointsBalance extends Equatable {
  const PointsBalance({
    required this.totalPoints,
    required this.pendingPoints,
    required this.expiringPoints,
    required this.expiringDate,
    required this.lastUpdated,
    required this.balancesByMerchant,
  });

  final int totalPoints;
  final int pendingPoints;
  final int expiringPoints;
  final DateTime expiringDate;
  final DateTime lastUpdated;
  final List<MerchantBalance> balancesByMerchant;

  factory PointsBalance.fromJson(Map<String, dynamic> json) =>
      _$PointsBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$PointsBalanceToJson(this);

  PointsBalance copyWith({
    int? totalPoints,
    int? pendingPoints,
    int? expiringPoints,
    DateTime? expiringDate,
    DateTime? lastUpdated,
    List<MerchantBalance>? balancesByMerchant,
  }) => PointsBalance(
    totalPoints: totalPoints ?? this.totalPoints,
    pendingPoints: pendingPoints ?? this.pendingPoints,
    expiringPoints: expiringPoints ?? this.expiringPoints,
    expiringDate: expiringDate ?? this.expiringDate,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    balancesByMerchant: balancesByMerchant ?? this.balancesByMerchant,
  );

  @override
  List<Object?> get props => [
    totalPoints,
    pendingPoints,
    expiringPoints,
    expiringDate,
    lastUpdated,
    balancesByMerchant,
  ];
}
