// To parse this JSON data, do
//
//     final read = readFromJson(jsonString);

import 'dart:convert';

Read readFromJson(String str) => Read.fromJson(json.decode(str));

String readToJson(Read data) => json.encode(data.toJson());

class Read {
    int qr;

    Read({
        required this.qr,
    });

    factory Read.fromJson(Map<String, dynamic> json) => Read(
        qr: json["qr"],
    );

    Map<String, dynamic> toJson() => {
        "qr": qr,
    };
}
