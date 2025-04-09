import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tima_app/app/core/service/navigation_service.dart';
import 'package:tima_app/app/feature/No-Internet/not_connected.dart';

class ConnectionStatusListener {
  static final _singleton = ConnectionStatusListener._internal();

  ConnectionStatusListener._internal();

  bool hasShowNoInternet = false;

  bool hashConnection = false;

  Connectivity _connectivity = Connectivity();

  static ConnectionStatusListener getInstance() => _singleton;

  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  void _connectionChange(List<ConnectivityResult> result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hashConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hashConnection = true;
      } else {
        hashConnection = false;
      }
    } on SocketException catch (_) {
      hashConnection = false;
    }
    if (previousConnection != hashConnection) {
      connectionChangeController.add(hashConnection);
    }
    return hashConnection;
  }

  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    await checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }
}

updateConnectivity(
  dynamic hashConnection,
  ConnectionStatusListener connectionStatus,
) {
  log("HashConnection =>> $hashConnection");

  if (!hashConnection) {
    connectionStatus.hasShowNoInternet = true;
    NavigationService().navigateToScreen(NoInternetConnection());
  } else {
    if (connectionStatus.hasShowNoInternet) {
      connectionStatus.hasShowNoInternet = false;
      NavigationService().goBack();
    }
  }
}

initNoInternetListener() async {
  var connectionStatus = ConnectionStatusListener.getInstance();
  await connectionStatus.initialize();
  if (!connectionStatus.hashConnection) {
    updateConnectivity(false, connectionStatus);
  } else {
    connectionStatus.connectionChange.listen((event) {
      log("initNoInternetListener =>> $event");
      updateConnectivity(event, connectionStatus);
    });
  }
}
