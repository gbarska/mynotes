import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/auth_provider.dart';

class WindowsAuthProvider implements AuthProvider {
  bool isLogged = false;
  bool isConfirmed = false;

  @override
  Future<void> initialize() async {
    return Future(() => null);
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
     return Future(() => getMockedUser);
  }

 AuthUser get getMockedUser {
    return AuthUser(id: '1234', email: 'mario@gmail.com', isEmailVerified: isConfirmed);
  }


  @override
  AuthUser? get currentUser {
    if(isLogged) {
      return getMockedUser;
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    isLogged = true;
   return Future(() => getMockedUser);
  }

  @override
  Future<void> logOut() async {
    isLogged = false;    
    return Future(() => null);
  }

  @override
  Future<void> sendEmailVerification() async {
    isConfirmed = true;
   return Future(() => null);
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    return Future(() => null);
  }
}