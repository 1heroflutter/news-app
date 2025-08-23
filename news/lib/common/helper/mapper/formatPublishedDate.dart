import 'package:intl/intl.dart';

String formatPublishedDate(DateTime publishedAt) {
  final now = DateTime.now();
  final difference = now.difference(publishedAt);

  if (difference.inHours < 24) {
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  } else {
    return DateFormat('dd/MM/yyyy').format(publishedAt);
  }
}
