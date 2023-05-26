import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../../../widgets/TopBar.dart';

class CustomerQRCodeScanner extends StatefulWidget {
  const CustomerQRCodeScanner({Key? key}) : super(key: key);

  @override
  State<CustomerQRCodeScanner> createState() => _CustomerQRCodeScannerState();
}

class _CustomerQRCodeScannerState extends State<CustomerQRCodeScanner> {

  var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandManAppBar1(title: "Scan QR", bgcolor: Color(0xff000000), titlecolor: Colors.white, iconcolor: Colors.white,),
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  scanQRCode();
                },
                child: Text('Scan QR'),
              ),
              SizedBox(height: 20.0,),
              Text(getResult),
            ],
          )
      ),
    );
  }

  void scanQRCode() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }

  }

}