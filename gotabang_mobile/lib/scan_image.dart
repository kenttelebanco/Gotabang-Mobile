// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';
import 'package:gotabang_mobile/login_screen.dart';
import 'package:gotabang_mobile/storage_service.dart';
import 'package:file_picker/file_picker.dart';

class ScanImageScreen extends StatefulWidget {
  const ScanImageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScanImageState createState() => _ScanImageState();
}

class _ScanImageState extends State<ScanImageScreen> {
  String path = '';
  String fileName = '';
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: const Color(0xff1d283f),
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu_outlined), onPressed: () => {}),
        title: const Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text('Scan Image'))),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff1d283f),
        elevation: 4.0,
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications_none), onPressed: () => {}),
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                  }),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            const Image(
              image: AssetImage('assets/gotabang_upload.png'),
              height: 300.0,
              fit: BoxFit.fill,
            ),
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
              children: [
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        final results = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg'],
                        );

                        if (results == null) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No File Selected'),
                            ),
                          );
                          return;
                        }

                        path = results.files.single.path!;
                        fileName = results.files.single.name;
                      },
                      child: const Text(
                        'Select File',
                      )),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        storage
                            .uploadFile(path, fileName)
                            .then((value) => print('done'));

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            icon: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check,
                                  size: 60,
                                  color: Color.fromARGB(255, 38, 221, 53)),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  "Successfully Uploaded!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        'Upload File',
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
