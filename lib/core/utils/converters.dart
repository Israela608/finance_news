import 'package:finance_news/data/constants/strings.dart';

String formatUnixDate(int? timestamp) {
  if (timestamp == null) return '';
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return '${date.day} ${_monthName(date.month)} ${date.year}';
}

String _monthName(int month) {
  const months = Strings.months;
  return months[month];
}
