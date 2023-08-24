// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../scan/scan.dart';
import '/constants.dart';

class BodyWidget extends StatefulWidget {
  final String? data;
  final int? status;
  const BodyWidget({super.key, this.data, this.status});

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  String city = 'اختر المدينة';
  String gate = 'اختر البوابة';

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimarycolor,
          title: const Text('قارئ الـ QR'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 160,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownButtonHideUnderline(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      value: city,
                      onChanged: (newValue) {
                        setState(() {
                          city = newValue!;
                        });
                      },
                      items: <String>[
                        'اختر المدينة',
                        ' امل ١ ',
                        'امل ٢',
                        'امل ٣'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownButtonHideUnderline(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(4)),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      value: gate,
                      onChanged: (newValue) {
                        setState(() {
                          gate = newValue!;
                        });
                      },
                      items: <String>[
                        'اختر البوابة',
                        'البوابة الاولى',
                        'البوابة الثانية'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => kPrimarycolor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  QRScanner(city: city,gate: gate,),
                      ),
                    );
                  },
                  child: const Text(
                    'قراءة الـ QR',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              widget.status == 1
                  ? Image.asset(
                      'assets/images/true.png',
                      width: 140,
                    )
                  : widget.status == 2
                      ? Image.asset(
                          'assets/images/false.png',
                          width: 140,
                        )
                      : const Text('')
            ],
          ),
        ),
      ),
    );
  }
}
