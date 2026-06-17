import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'merchant_balance.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MerchantBalance extends Equatable {
  const MerchantBalance({
    required this.merchantId,
    required this.merchantName,
    required this.merchantLogo,
    required this.points,
    required this.tier,
  });

  final String merchantId;
  final String merchantName;
  final String merchantLogo;
  final int points;
  final String tier;

  factory MerchantBalance.fromJson(Map<String, dynamic> json) =>
      _$MerchantBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantBalanceToJson(this);

  MerchantBalance copyWith({
    String? merchantId,
    String? merchantName,
    String? merchantLogo,
    int? points,
    String? tier,
  }) => MerchantBalance(
    merchantId: merchantId ?? this.merchantId,
    merchantName: merchantName ?? this.merchantName,
    merchantLogo: merchantLogo ?? this.merchantLogo,
    points: points ?? this.points,
    tier: tier ?? this.tier,
  );

  @override
  List<Object?> get props => [
    merchantId,
    merchantName,
    merchantLogo,
    points,
    tier,
  ];
}
