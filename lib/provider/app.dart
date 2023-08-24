import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../screens/home/components/body.dart';

class AppProvider extends ChangeNotifier {
  Api api = Api();
  late SnackBar snackBar;

  sendOrder(qrData, city, gate, context) async {
    var data = {'qr_data': qrData, "city": city, "gate": gate};
    if (kDebugMode) {
      print(data);
    }
    final response = await api.postData(data, 'Reader');
    if (response.statusCode == 200 || response.statusCode == 201) {
      
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data['qr']);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BodyWidget(status: data['qr'], data: qrData),
        ),
      );
      notifyListeners();
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  void snackbar(context, String text) {
    snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
