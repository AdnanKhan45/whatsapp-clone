
import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final today = DateTime.now();
  final tomorrow = DateTime.now().add(Duration(days: 1));
  final yesterday = DateTime.now().subtract(Duration(days: 1));

  final timeFormatter = DateFormat('h:mm a');

  if (dateTime.year == today.year && dateTime.month == today.month && dateTime.day == today.day) {
    return 'Today, ${timeFormatter.format(dateTime)}';
  } else if (dateTime.year == tomorrow.year && dateTime.month == tomorrow.month && dateTime.day == tomorrow.day) {
    return 'Tomorrow, ${timeFormatter.format(dateTime)}';
  } else if (dateTime.year == yesterday.year && dateTime.month == yesterday.month && dateTime.day == yesterday.day) {
    return 'Yesterday, ${timeFormatter.format(dateTime)}';
  } else {
    final dateFormatter = DateFormat('MMM d');
    return '${dateFormatter.format(dateTime)}, ${timeFormatter.format(dateTime)}';
  }
}