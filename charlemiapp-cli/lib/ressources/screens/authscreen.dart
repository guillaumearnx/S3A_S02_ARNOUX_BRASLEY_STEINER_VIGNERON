import 'package:charlemiapp_cli/ressources/loader.dart';
import 'package:charlemiapp_cli/services/authentication.dart';
import 'package:flutter/material.dart';

import '../nav.dart';

final AuthenticationService _auth = AuthenticationService();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('Home'),
        ),
      );
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('Explore'),
        ),
      );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Nav.loading
      ? Loader()
      : Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: usernameController,
                  validator: AuthenticationService.validateEmail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? "Enter a valid password" : null,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        Nav.loading = true;
                      });
                      final String username = usernameController.text;
                      final String password = passwordController.text;
                      Nav.user = await _auth.signInWithEmailAndPassword(username, password);
                      Nav.loading = false;
                      if (Nav.user == null) {
                        setState(() {
                          error = "Invalid username or password";
                          passwordController.clear();

                        });
                      }
                    }
                  },
                  child: const Text('Log in'),
                ),
                ElevatedButton(
                  child: const Text('Sign up'),
                  onPressed: () => {
                    //TODO REGISTER
                  },
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 15),
                ),
              ],
            ),
          ),
        );
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('Register'),
        ),
      );
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) => Nav.loading
      ? Loader()
      : Center(
          child: Column(children: [
            Text('Bonjour ${Nav.user!.lastName} ${Nav.user!.firstName}'),
            ElevatedButton(
                onPressed: () async => {
                      setState(() {
                        Nav.loading = true;
                      }),
                      await _auth.signOut(),
                      setState(() {
                        Nav.loading = false;
                      }),
                    },
                child: const Text('Log out'))
          ]),
        );
}
