import 'package:local_auth/local_auth.dart';

final LocalAuthentication _localAuthentication = LocalAuthentication();

class AuthBio {
  Future<void> checkBiometric() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    print('Biometrics supported: $canCheckBiometrics');
  }

  Future<void> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await _localAuthentication.getAvailableBiometrics();
    print('Available biometrics: $availableBiometrics');
  }

  Future<void> authenticate() async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: false,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('Error during biometric authentication: $e');
    }

    if (isAuthenticated) {
      print('Biometric authentication successful');
    } else {
      print('Biometric authentication failed');
    }
  }

  load() async {
    await checkBiometric();
    await getAvailableBiometrics();
    await authenticate();
  }
}
