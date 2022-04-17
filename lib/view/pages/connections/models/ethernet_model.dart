import 'package:nm/nm.dart';

import 'property_stream_notifier.dart';

part 'ethernet_device_model.dart';

class EthernetModel extends PropertyStreamNotifier {
  final NetworkManagerClient _networkManagerClient;

  List<EthernetDeviceModel> get ethernetDevices => _networkManagerClient.devices
      .where((device) => device.wired != null)
      .map((device) => EthernetDeviceModel(device))
      .toList();

  EthernetModel(this._networkManagerClient) {
    addProperties(_networkManagerClient.propertiesChanged);
    addPropertyListener('Devices', notifyListeners);
  }

  String _errorMessage = '';
  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  Future<bool> toggleInterface(
    NetworkManagerDevice device,
    NetworkManagerActiveConnection? connection,
  ) async {
    try {
      connection != null
          ? await _networkManagerClient.deactivateConnection(connection)
          : await _networkManagerClient.activateConnection(device: device);
      return true;
    } on Exception catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  String get errorMessage => _errorMessage;
}
