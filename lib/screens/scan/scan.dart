import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '/provider/app.dart';

import '../../constants.dart';

class QRScanner extends StatefulWidget {
  final String? gate;
  final String? city;
   const QRScanner({super.key,this.city,this.gate});

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  QRViewController? _controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    var app = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimarycolor,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                _controller = controller;
                controller.scannedDataStream.listen((scanData) {
                  _controller?.stopCamera();

                  app.sendOrder(scanData.code,widget.city,widget.gate,context);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         BodyWidget(status: 2, data: scanData.code),
                  //   ),
                  // );
                  if (kDebugMode) {
                    print("ALI-JAAFAR  ${scanData.code}");
                  }
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => kPrimarycolor,
                      ),
                    ),
                    onPressed: () {
                      _controller?.toggleFlash();
                    },
                    child: FutureBuilder<bool?>(
                      future: _controller?.getFlashStatus(),
                      builder: (context, snapshot) {
                        return Text(
                          'Flash: ${snapshot.data ?? false}',
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => kPrimarycolor,
                      ),
                    ),
                    onPressed: () {
                      _controller?.flipCamera();
                    },
                    child: FutureBuilder(
                      future: _controller?.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Text(
                              'Camera facing ${describeEnum(snapshot.data!)}');
                        } else {
                          return const Text('Loading camera...');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}