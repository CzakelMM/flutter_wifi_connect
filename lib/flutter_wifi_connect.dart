import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

class FlutterWifiConnect {
  static const MethodChannel _channel =
      const MethodChannel('flutter_wifi_connect');

  /// The [connect] method attempts to connect to wifi
  /// matching explicitly the [ssid] parameter.
  static Future<bool> connect(String ssid, {bool saveNetwork = false}) async {
    final bool? connected = await _channel.invokeMethod<bool>(
        'connect', {'ssid': ssid, 'saveNetwork': saveNetwork});
    return connected ?? false;
  }

  /// The [connectByPrefix] method attempts to connect to the nearest wifi
  /// network with the ssid prefix matching the [ssidPrefix] parameter.
  static Future<bool> connectByPrefix(String ssidPrefix,
      {bool saveNetwork = false}) async {
    final bool? connected = await _channel.invokeMethod<bool>(
        'prefixConnect', {'ssid': ssidPrefix, 'saveNetwork': saveNetwork});
    return connected ?? false;
  }

  /// The [connectToSecureNetwork] method attempts to connect to wifi
  /// matching explicitly the [ssid] parameter. This will fail if the
  /// [password] doesn't match or the [isWep] parameter isn't set correctly.
  /// Android does not support WEP Networks.
  static Future<bool> connectToSecureNetwork(String ssid, String password,
      {bool isWep = false,
      bool isWpa3 = false,
      bool saveNetwork = false}) async {
    final bool? connected = await _channel.invokeMethod<bool>('secureConnect', {
      'ssid': ssid,
      'password': password,
      'saveNetwork': saveNetwork,
      'isWep': isWep,
      'isWpa3': isWpa3,
    });
    return connected ?? false;
  }

  /// The [connectToSecureNetworkByPrefix] method attempts to connect to the nearest
  /// wifi network with the ssid prefix matching the [ssidPrefix] parameter.
  /// This will fail if the [password] doesn't match or the [isWep] parameter
  /// isn't set correctly. Android does not support WEP Networks.
  static Future<bool> connectToSecureNetworkByPrefix(
      String ssidPrefix, String password,
      {bool isWep = false,
      bool isWpa3 = false,
      bool saveNetwork = false}) async {
    final bool? connected =
        await _channel.invokeMethod<bool>('securePrefixConnect', {
      'ssid': ssidPrefix,
      'password': password,
      'saveNetwork': saveNetwork,
      'isWep': isWep,
      'isWpa3': isWpa3,
    });
    return connected ?? false;
  }

  /// The [disconnect] method disconnects from the wifi network if the network
  /// was connected to using one of the [connect] methods.
  static Future<bool> disconnect() async {
    final bool? disconnect = await _channel.invokeMethod('disconnect');
    return disconnect ?? false;
  }

  /// The [ssid] getter returns the currently connected ssid.
  static Future<String> get ssid async {
    final String? ssid = await _channel.invokeMethod<String>('getSSID');
    return ssid ?? "";
  }
}
