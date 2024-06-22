import 'package:biometric_auth/auth_bio.dart';
import 'package:biometric_auth/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final authBio = AuthBio();
  @override
  void initState() {
    authBio.load();
    screenLockMethod();
    super.initState();
  }

  screenLockMethod() {
    return screenLock(
      context: context,
      correctString: '1234',
      customizedButtonChild: const Icon(Icons.fingerprint),
      customizedButtonTap: () async {
        await authBio.load();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('Bio Authentication!!!'),
          ),
        ],
      ),
    );
  }
}
