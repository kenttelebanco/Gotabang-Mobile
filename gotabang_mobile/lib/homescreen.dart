// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gotabang_mobile/scan_image.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

Widget CardWidgetUpload(BuildContext context) {
  return Center(
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ScanImageScreen(),
            ),
          ),
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              ListTile(
                leading: Icon(Icons.cloud_upload_outlined),
                title: Text('Scan Image'),
                subtitle: Text('Ready For Scanning'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget CardWidgetScan() {
  return Center(
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.scanner_outlined),
            title: Text('Detect Data'),
            subtitle:
                Text('Retrieve Disaster Recognition and Damage Assesment'),
          ),
        ],
      ),
    ),
  );
}

Widget CardWidgetAlert() {
  return Center(
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text('Alert Rescue'),
            subtitle: Text('Send sms and email to nearby respondents'),
          ),
        ],
      ),
    ),
  );
}

class _HomeScreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d283f),
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu_outlined), onPressed: () => {}),
        title: const Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: Text('Dashboard'))),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff1d283f),
        elevation: 4.0,
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications_none), onPressed: () => {}),
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => {
                    FirebaseAuth.instance.signOut(),
                  }),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Image.asset(
                'assets/gotabang_landscape.png',
                height: 200,
                width: 550,
                fit: BoxFit.cover,
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Welcome User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  CardWidgetUpload(context),
                  CardWidgetScan(),
                  CardWidgetAlert(),
                ]),
          ],
        ),
      ),
    );
  }
}
