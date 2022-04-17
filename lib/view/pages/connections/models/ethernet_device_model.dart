part of 'ethernet_model.dart';

class EthernetDeviceModel extends PropertyStreamNotifier {
  final NetworkManagerDevice _networkManagerDevice;
  late final NetworkManagerDeviceWired _networkManagerDeviceWired;

  EthernetDeviceModel(this._networkManagerDevice) {
    _networkManagerDeviceWired = _networkManagerDevice.wired!;

    addProperties(_networkManagerDevice.propertiesChanged);
  }

  NetworkManagerActiveConnection? get connection =>
      _networkManagerDevice.activeConnection;
  NetworkManagerDevice get networkDevice => _networkManagerDevice;
  int get speed => _networkManagerDeviceWired.speed;

  bool get isActive =>
      _networkManagerDevice.state == NetworkManagerDeviceState.activated;
}
