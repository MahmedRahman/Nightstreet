import 'package:connectivity/connectivity.dart';

class InternetConnectionService {
  final connectivity = Connectivity();

  Future<bool> checkConnection() async {
    final result = await connectivity.checkConnectivity();
    return (result != ConnectivityResult.none);
  }
}
