// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['id'] as String,
  type: $enumDecode(
    _$TransactionTypeEnumMap,
    json['type'],
    unknownValue: TransactionType.earn,
  ),
  points: (json['points'] as num).toInt(),
  description: json['description'] as String,
  merchantName: json['merchant_name'] as String?,
  merchantLogo: json['merchant_logo'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  status: $enumDecode(
    _$TransactionStatusEnumMap,
    json['status'],
    unknownValue: TransactionStatus.pending,
  ),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'points': instance.points,
      'description': instance.description,
      'merchant_name': instance.merchantName,
      'merchant_logo': instance.merchantLogo,
      'created_at': instance.createdAt.toIso8601String(),
      'status': _$TransactionStatusEnumMap[instance.status]!,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.earn: 'EARN',
  TransactionType.redeem: 'REDEEM',
  TransactionType.transferIn: 'TRANSFER_IN',
  TransactionType.transferOut: 'TRANSFER_OUT',
  TransactionType.purchase: 'PURCHASE',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'PENDING',
  TransactionStatus.completed: 'COMPLETED',
  TransactionStatus.failed: 'FAILED',
};
