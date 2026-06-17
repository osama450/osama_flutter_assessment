// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsPage _$TransactionsPageFromJson(Map<String, dynamic> json) =>
    TransactionsPage(
      items: (json['items'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      totalCount: (json['total_count'] as num).toInt(),
      hasMore: json['has_more'] as bool,
    );

Map<String, dynamic> _$TransactionsPageToJson(TransactionsPage instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'page': instance.page,
      'page_size': instance.pageSize,
      'total_count': instance.totalCount,
      'has_more': instance.hasMore,
    };
