import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../utils/sb.dart';

class NetworkStatus extends StatefulWidget {
  const NetworkStatus({super.key});

  @override
  _NetworkStatusState createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isNetworkAvailable = true;
  String _lable = '';
  String _message = '';
  Color _backgroundColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _startMonitoringConnectivity();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _checkInitialConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isNetworkAvailable = connectivityResult != ConnectivityResult.none;
      _lable = _isNetworkAvailable ? '' : 'You’re Offline';
      _message = _isNetworkAvailable ? '' : 'Please connect to the internet and try again';
      _backgroundColor = _isNetworkAvailable ? Colors.transparent : Colors.black;
    });
  }

  void _startMonitoringConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> resultList) {
      final connectivityResult = resultList.isNotEmpty ? resultList.first : ConnectivityResult.none;
      final isNetworkAvailable = connectivityResult != ConnectivityResult.none;

      if (isNetworkAvailable) {
        if (!_isNetworkAvailable) {
          setState(() {
            _isNetworkAvailable = true;
            _lable = 'Back to online';
            _message = 'You’re now connected.';
            _backgroundColor = Colors.green;
          });
          // Hide message after 2 seconds
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _lable = '';
                _message = '';
                _backgroundColor = Colors.transparent;
              });
            }
          });
        }
      } else {
        setState(() {
          _isNetworkAvailable = false;
          _lable = 'You’re Offline';
          _message = 'Please connect to the internet and try again';
          _backgroundColor = Colors.black; // Color when offline
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _lable.isNotEmpty,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isNetworkAvailable ? Icons.wifi : Icons.wifi_off_sharp,
                  color: Colors.white,
                  size: 14,
                ),
                SB.w(7),
                Row(
                  children: [
                    Text(
                        _lable,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12, color: Colors.white
                        )
                    ),
                    SB.w(10),
                    Text(
                        _message,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12, color: Colors.white
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
