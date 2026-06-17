import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'transaction.dart';

part 'transactions_page.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TransactionsPage extends Equatable {
  const TransactionsPage({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasMore,
  });

  final List<Transaction> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasMore;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isEmpty => items.isEmpty;

  factory TransactionsPage.fromJson(Map<String, dynamic> json) =>
      _$TransactionsPageFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsPageToJson(this);

  TransactionsPage copyWith({
    List<Transaction>? items,
    int? page,
    int? pageSize,
    int? totalCount,
    bool? hasMore,
  }) => TransactionsPage(
    items: items ?? this.items,
    page: page ?? this.page,
    pageSize: pageSize ?? this.pageSize,
    totalCount: totalCount ?? this.totalCount,
    hasMore: hasMore ?? this.hasMore,
  );

  @override
  List<Object?> get props => [items, page, pageSize, totalCount, hasMore];
}
