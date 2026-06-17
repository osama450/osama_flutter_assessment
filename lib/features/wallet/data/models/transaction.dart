import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonEnum()
enum TransactionType {
  @JsonValue('EARN')
  earn,
  @JsonValue('REDEEM')
  redeem,
  @JsonValue('TRANSFER_IN')
  transferIn,
  @JsonValue('TRANSFER_OUT')
  transferOut,
  @JsonValue('PURCHASE')
  purchase,
}

extension TransactionTypeX on TransactionType {
  String get json => switch (this) {
    TransactionType.earn => 'EARN',
    TransactionType.redeem => 'REDEEM',
    TransactionType.transferIn => 'TRANSFER_IN',
    TransactionType.transferOut => 'TRANSFER_OUT',
    TransactionType.purchase => 'PURCHASE',
  };
}

@JsonEnum()
enum TransactionStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('FAILED')
  failed,
}

extension TransactionStatusX on TransactionStatus {
  String get json => switch (this) {
    TransactionStatus.pending => 'PENDING',
    TransactionStatus.completed => 'COMPLETED',
    TransactionStatus.failed => 'FAILED',
  };
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.type,
    required this.points,
    required this.description,
    this.merchantName,
    this.merchantLogo,
    required this.createdAt,
    required this.status,
  });

  final String id;
  @JsonKey(unknownEnumValue: TransactionType.earn)
  final TransactionType type;
  final int points;
  final String description;
  final String? merchantName;
  final String? merchantLogo;
  final DateTime createdAt;
  @JsonKey(unknownEnumValue: TransactionStatus.pending)
  final TransactionStatus status;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  Transaction copyWith({
    String? id,
    TransactionType? type,
    int? points,
    String? description,
    String? merchantName,
    String? merchantLogo,
    DateTime? createdAt,
    TransactionStatus? status,
  }) => Transaction(
    id: id ?? this.id,
    type: type ?? this.type,
    points: points ?? this.points,
    description: description ?? this.description,
    merchantName: merchantName ?? this.merchantName,
    merchantLogo: merchantLogo ?? this.merchantLogo,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    id,
    type,
    points,
    description,
    merchantName,
    merchantLogo,
    createdAt,
    status,
  ];
}
