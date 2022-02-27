import 'models/cart.dart';
import 'ressources/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(const CharlemiappInstance());
}

class CharlemiappInstance extends StatelessWidget {
  const CharlemiappInstance({Key? key}) : super(key: key);
  static late Cart cart;

  @override
  Widget build(BuildContext context) {
    cart = Cart();
    /*StreamProvider<AppUser?>.value(value: AuthenticationService().user, catchError: (_, __) => null, initialData: null, child:*/
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CharleMi\'App',
      home: Home(),
    );
  }
}
