part of 'helpers.dart';

abstract class CacheHelper {
  Future<bool> setInt(String key,int value);
  Future<bool> setBool(String key, bool value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setString(String key, String value);
  Future<bool> setStringList(String key, List<String> value);
  Future<int?> getInt(String key);
  Future<bool?> getBool(String key, bool value);
  Future<double?> getDouble(String key);
  Future<String?> getString(String key);
  Future<List<String>?> getStringList(String key);
  Future<bool> clear();

}

class CacheHelperImpl extends CacheHelper {
  @override
  Future<bool?> getBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  @override
  Future<double?> getDouble(String key) async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getDouble(key);
  }

  @override
  Future<int?> getInt(String key) async{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getInt(key);
  }

  @override
  Future<String?> getString(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<List<String>?> getStringList(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  @override
  Future<bool> setDouble(String key, double value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(key, value);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  @override
  Future<bool> setString(String key, String value)async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }
  
  @override
  Future<bool> clear() async{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.clear();
   return true;
  }
  

}