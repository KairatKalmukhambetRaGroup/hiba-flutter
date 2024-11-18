part of 'utils_library.dart';

String dateToDayAndMonth(DateTime dateTime) {
  int thisYear = DateTime.now().year;
  int year = dateTime.year;

  DateFormat format;
  if (thisYear == year) {
    format = DateFormat("dd MMMM");
  } else {
    format = DateFormat("dd MMMM, yyyy");
  }

  return format.format(dateTime);
}

String howLongAgo(DateTime? dateTime) {
  if (dateTime == null) return '';

  final Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} секунд назад';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} минут назад';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} часов назад';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} дней назад';
  } else if (difference.inDays < 30) {
    return '${(difference.inDays / 7).floor()} недель назад';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()} месяцев назад';
  } else {
    return '${(difference.inDays / 365).floor()} годов назад';
  }
}

String howLongAgoString(String? dateString) {
  if (dateString == null) return '';

  DateTime dateTime = DateTime.parse(dateString);
  final Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} секунд назад';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} минут назад';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} часов назад';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} дней назад';
  } else if (difference.inDays < 30) {
    return '${(difference.inDays / 7).floor()} недель назад';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()} месяцев назад';
  } else {
    return '${(difference.inDays / 365).floor()} годов назад';
  }
}

String dateToTime(DateTime? dateTime) {
  if (dateTime == null) return '';

  return '${dateTime.hour}:${dateTime.minute}';
}

String dateToTimeString(String? dateString) {
  if (dateString == null) return '';
  DateTime dateTime;
  try {
    dateTime = DateTime.parse(dateString);
  } catch (e) {
    dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(dateString));
  }

  return '${dateTime.hour}:${dateTime.minute}';
}
