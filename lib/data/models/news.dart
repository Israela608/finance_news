import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String? bankName;
  final String? accountName;
  final String? accountNumber;

  const News({
    this.bankName,
    this.accountName,
    this.accountNumber,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      bankName: json['bank_name'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
    );
  }

  static List<News> fromListJson(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return [];
    }
    return jsonList.map((json) => News.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [bankName, accountName, accountNumber];
}
