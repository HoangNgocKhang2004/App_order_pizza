import 'package:intl/intl.dart';

class FormatUtils {

  static String formattedPrice(int gia){
    return NumberFormat("#,###").format(gia);
  }

  static String formattedPriceDouble(double gia){
    return NumberFormat("#,###").format(gia);
  }

  static String formattedDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
  
}