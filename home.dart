import 'package:biometric_auth/auth_bio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final authBio = AuthBio();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      lockMethod();
    });
  }

  lockMethod() async {
    await screenLock(
      context: context,
      correctString: '1234',
      customizedButtonChild: const Icon(Icons.fingerprint),
      customizedButtonTap: () async => await authBio.load(),
      cancelButton: TextButton(onPressed: () {}, child: const Text('Forgot')),
      onCancelled: () => lockMethod(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Next Screen Lock'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (context) {
                        return ScreenLock(
                          correctString: '1234',
                          onCancelled: Navigator.of(context).pop,
                          onUnlocked: Navigator.of(context).pop,
                        );
                      },
                    ),
                    child: const Text('Manually open'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      canCancel: false,
                    ),
                    child: const Text('Not cancelable'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      customizedButtonChild: const Icon(Icons.fingerprint),
                      customizedButtonTap: () async => await authBio.load(),
                      cancelButton: TextButton(
                          onPressed: () {}, child: const Text('Forgot')),
                      // onCancelled: () => lockMethod(),
                      // config:
                      //   const ScreenLockConfig(backgroundColor: Colors.green),
                    ),
                    child: const Text(
                      'use local_auth \n(Show local_auth when opened)',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '123456',
                      canCancel: false,
                      footer: Container(
                        width: 68,
                        height: 68,
                        padding: const EdgeInsets.only(top: 10),
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Cancel'),
                          ),
                        ),
                      ),
                    ),
                    child: const Text('Using footer'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      useBlur: false,
                      config: const ScreenLockConfig(
                        /// If you don't want it to be transparent, override the config
                        backgroundColor: Colors.black,
                        titleTextStyle: TextStyle(fontSize: 24),
                      ),
                    ),
                    child: const Text('Not blur'),
                  ),
                  ElevatedButton(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (context) => ScreenLock(
                        correctString: '1234',
                        keyPadConfig: const KeyPadConfig(
                          clearOnLongPressed: true,
                        ),
                        onUnlocked: Navigator.of(context).pop,
                      ),
                    ),
                    child: const Text('Delete long pressed to clear input'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      useLandscape: false,
                    ),
                    child: const Text('Disable landscape mode'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  static show(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NextPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
    );
  }
}
