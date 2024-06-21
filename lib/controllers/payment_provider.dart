import 'package:ecommerce_app/widgets/export_packages.dart';

class PaymentNotifier with ChangeNotifier {
  String? _paymentUrl;

  String get paymentUrl => _paymentUrl ?? "";

  set paymentUrl(String newState) {
    _paymentUrl = newState;
    notifyListeners();
  }
}