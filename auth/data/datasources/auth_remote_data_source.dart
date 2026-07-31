import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String farmLocation,
  });
  Future<UserModel> loginAsGuest();
  Future<void> sendPasswordReset(String email);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fb_auth.FirebaseAuth? firebaseAuth;
  final FirebaseFirestore? firestore;
  final SharedPreferences? sharedPreferences;

  static const String _userCacheKey = 'agrosafe_logged_in_user';

  // In-memory fallback state for testing or offline execution
  final Map<String, UserModel> _mockUserStore = {};
  UserModel? _currentMockUser;

  AuthRemoteDataSourceImpl({
    this.firebaseAuth,
    this.firestore,
    this.sharedPreferences,
  });

  bool get _isFirebaseAvailable {
    try {
      return firebaseAuth != null && firestore != null;
    } catch (_) {
      return false;
    }
  }

  Future<void> _persistUserLocally(UserModel user) async {
    _currentMockUser = user;
    if (sharedPreferences != null) {
      final mapData = user.toMap();
      mapData['uid'] = user.uid;
      await sharedPreferences!.setString(_userCacheKey, jsonEncode(mapData));
    }
  }

  Future<void> _clearLocalUserCache() async {
    _currentMockUser = null;
    if (sharedPreferences != null) {
      await sharedPreferences!.remove(_userCacheKey);
    }
  }

  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    if (_isFirebaseAvailable) {
      try {
        final credential = await firebaseAuth!.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final uid = credential.user!.uid;

        final doc = await firestore!
            .collection(AppConstants.usersCollection)
            .doc(uid)
            .get();

        UserModel userModel;
        if (doc.exists && doc.data() != null) {
          userModel = UserModel.fromMap(doc.data()!, uid);
        } else {
          userModel = UserModel(
            uid: uid,
            email: email,
            fullName: email.split('@').first,
            farmLocation: 'Musanze, Northern Province',
          );
        }
        await _persistUserLocally(userModel);
        return userModel;
      } catch (e) {
        throw AuthException(e.toString());
      }
    } else {
      // In-memory / Mock authentication
      final user = _mockUserStore.values.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase(),
        orElse: () {
          final newUser = UserModel(
            uid: 'mock_uid_${email.hashCode}',
            email: email,
            fullName: email.contains('@')
                ? email.split('@').first
                : 'Agro Farmer',
            farmLocation: 'Musanze District',
          );
          _mockUserStore[newUser.uid] = newUser;
          return newUser;
        },
      );
      await _persistUserLocally(user);
      return user;
    }
  }

  @override
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String farmLocation,
  }) async {
    if (_isFirebaseAvailable) {
      try {
        final credential = await firebaseAuth!.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final uid = credential.user!.uid;

        // Security best practice: send a verification email on sign-up so the
        // user can confirm ownership of the address before it is trusted.
        try {
          await credential.user!.sendEmailVerification();
        } catch (_) {
          // Non-fatal: registration still succeeds even if the email
          // (e.g. offline / rate-limited) could not be dispatched right now.
        }

        final userModel = UserModel(
          uid: uid,
          email: email,
          fullName: fullName,
          farmLocation: farmLocation,
          role: 'Farmer',
          isAnonymous: false,
        );

        await firestore!
            .collection(AppConstants.usersCollection)
            .doc(uid)
            .set(userModel.toMap());

        await _persistUserLocally(userModel);
        return userModel;
      } catch (e) {
        throw AuthException(e.toString());
      }
    } else {
      final newUser = UserModel(
        uid: 'mock_uid_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        fullName: fullName,
        farmLocation: farmLocation,
        role: 'Farmer',
        isAnonymous: false,
      );
      _mockUserStore[newUser.uid] = newUser;
      await _persistUserLocally(newUser);
      return newUser;
    }
  }

  @override
  Future<UserModel> loginAsGuest() async {
    if (_isFirebaseAvailable) {
      try {
        final credential = await firebaseAuth!.signInAnonymously();
        final uid = credential.user!.uid;
        final guestUser = UserModel(
          uid: uid,
          email: 'guest_${uid.substring(0, 5)}@agrosafe.rw',
          fullName: 'Guest Farmer',
          farmLocation: 'Northern Province',
          role: 'Guest',
          isAnonymous: true,
        );
        await firestore!
            .collection(AppConstants.usersCollection)
            .doc(uid)
            .set(guestUser.toMap());
        await _persistUserLocally(guestUser);
        return guestUser;
      } catch (e) {
        throw AuthException(e.toString());
      }
    } else {
      final guestUser = UserModel(
        uid: 'guest_${DateTime.now().millisecondsSinceEpoch}',
        email: 'guest@agrosafe.rw',
        fullName: 'Guest Farmer',
        farmLocation: 'Rwanda Agricultural Sector',
        role: 'Guest',
        isAnonymous: true,
      );
      await _persistUserLocally(guestUser);
      return guestUser;
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    if (_isFirebaseAvailable) {
      try {
        await firebaseAuth!.sendPasswordResetEmail(email: email);
      } catch (e) {
        throw AuthException(e.toString());
      }
    }
    // In mock/offline mode there is no real mailbox to hit, so we simply
    // resolve successfully — the UI shows the same confirmation either way.
  }

  @override
  Future<void> signOut() async {
    if (_isFirebaseAvailable) {
      await firebaseAuth!.signOut();
    }
    await _clearLocalUserCache();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    if (_isFirebaseAvailable) {
      final user = firebaseAuth!.currentUser;
      if (user != null) {
        final doc = await firestore!
            .collection(AppConstants.usersCollection)
            .doc(user.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          final userModel = UserModel.fromMap(doc.data()!, user.uid);
          await _persistUserLocally(userModel);
          return userModel;
        }
        final defaultUser = UserModel(
          uid: user.uid,
          email: user.email ?? '',
          fullName: 'Farmer',
          farmLocation: 'Musanze',
        );
        await _persistUserLocally(defaultUser);
        return defaultUser;
      }
    }

    // Check SharedPreferences cache
    if (sharedPreferences != null) {
      final cachedStr = sharedPreferences!.getString(_userCacheKey);
      if (cachedStr != null && cachedStr.isNotEmpty) {
        try {
          final Map<String, dynamic> map = jsonDecode(cachedStr);
          final uid = map['uid'] as String? ?? 'cached_uid';
          final cachedUser = UserModel.fromMap(map, uid);
          _currentMockUser = cachedUser;
          return cachedUser;
        } catch (_) {
          // ignore error
        }
      }
    }

    return _currentMockUser;
  }
}
