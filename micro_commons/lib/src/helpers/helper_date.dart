part of 'helpers.dart';

class HelperDate {
  static String getFormattedDate(DateTime date, {String? pattern}) {
    return DateFormat(pattern ?? 'dd/MM/yyyy').format(date);
  }
  static String getDayMonthName(DateTime date) {
    return DateFormat('dd MMMM', 'pt_Br').format(date);
  }
   static String getMonthYearName(DateTime date) {
    return DateFormat('MMMM yyyy', 'pt_Br').format(date);
  }
}
