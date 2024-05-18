import 'package:education_apps/core/errors/exceptions.dart';
import 'package:education_apps/core/utils/constants/constant_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalSource {
  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserFirstTimer();
}

class OnBoardingLocalSourceImp implements OnBoardingLocalSource {
  OnBoardingLocalSourceImp(this._sharedPref);

  final SharedPreferences _sharedPref;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _sharedPref.setBool(ConstantSharedPref.firstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserFirstTimer() async {
    try {
      return _sharedPref.getBool(ConstantSharedPref.firstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
