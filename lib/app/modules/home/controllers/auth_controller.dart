import 'package:clone_zoom/app/modules/home/model/user_model.dart';
import 'package:clone_zoom/app/modules/home/services.dart/database_services.dart';
import 'package:clone_zoom/app/modules/home/views/home_page.dart';
import 'package:clone_zoom/app/modules/home/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseServices db = DatabaseServices();
  late Rx<User?> _user;
  User? get user => _user.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

// Sign in with google function

  Future<bool> signInWithGoogle() async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          UserModel newUser = UserModel(
              uid: user.uid,
              username: user.displayName!,
              email: user.email!,
              profilephoto: user.photoURL!);
          await db.userCollection.doc(user.uid).set(newUser.toMap());
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Something went Wrong", e.toString());
      res = false;
    }
    return res;
  }

  signOut() {
    _auth.signOut();
  }
}
