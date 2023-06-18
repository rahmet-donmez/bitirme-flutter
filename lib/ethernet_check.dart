import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ikinci_el_arac_mobil/error.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Internet{
  //çağrıldığında bir kere çalışır
  void deneme()async{
    bool result = await InternetConnectionChecker().hasConnection;
if(result == true) {
  print('YAY! Free cute dog pics!');
} else {
  print('No internet :( Reason:');
}
  }


  Future<void> execute(
  InternetConnectionChecker internetConnectionChecker,
) async {
  // Simple check to see if we have Internet
  // ignore: avoid_print
  print('''The statement 'this machine is connected to the Internet' is: ''');
  final bool isConnected = await InternetConnectionChecker().hasConnection;
  // ignore: avoid_print
  print(
    isConnected.toString(),
  );
  // returns a bool

  // We can also get an enum instead of a bool
  // ignore: avoid_print
  print(
    'Current status: ${await InternetConnectionChecker().connectionStatus}',
  );
  // Prints either InternetConnectionStatus.connected
  // or InternetConnectionStatus.disconnected

  // actively listen for status updates
  final StreamSubscription<InternetConnectionStatus> listener =
      InternetConnectionChecker().onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          // ignore: avoid_print
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
          // ignore: avoid_print
          print('You are disconnected from the internet.');
          break;
      }
    },
  );

  // close listener after 30 seconds, so the program doesn't run forever
  
}

Future<void> main() async {
  // Check internet connection with singleton (no custom values allowed)
  await execute(InternetConnectionChecker());

  // Create customized instance which can be registered via dependency injection
 /* final InternetConnectionChecker customInstance =
      InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 1),
  );*/

  // Check internet connection with created instance
  //await execute(customInstance);
}

  //çağrıldığında sürekli kontrol eder
void internet_kontrol(BuildContext context) {
    final StreamSubscription<InternetConnectionStatus> listener =
      InternetConnectionChecker().onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          // ignore: avoid_print
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
          // ignore: avoid_print
          /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data")));
          er();
*/ showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        icon: const Icon(FontAwesomeIcons.exclamationCircle),
                        title:const Text('Uyarı'),
                        content: const Text(
                            'Lütfen internet bağlantınızı kontrol edin'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              //Navigator.pop(context);
                            },
                            child: const Text('Evet'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child:const Text('Tamam'),
                          ),
                        ],
                      ),
                    );


           print("gitti");
          break;
      }
      
    },
  );


  }

}