import 'package:shared_preferences/shared_preferences.dart';
/**
 * 存储数据到本地
 */
enum StoreKeys {
  token,
}
enum StoreName{
  name,
}
enum StorePassword{
  password,
}

class Store {
  // static StoreKeys storeKeys;
  final SharedPreferences _store;
  static Future<Store> getInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return Store._internal(preferences);
  }

  Store._internal(this._store);

  /**
   * 保存token
   */
  getString(StoreKeys key) async {
    return _store.get(key.toString());
  }

  setString(StoreKeys key, String value) async {
    return _store.setString(key.toString(), value);
  }

  /**
   * 保存用户名
   */
  getNameString(StoreName key) async {
    return _store.get(key.toString());
  }

  setNameString(StoreName key, String value) async {
    return _store.setString(key.toString(), value);
  }

  /**
   * 保存密码
   */

  getpasswordString(StorePassword key) async {
    return _store.get(key.toString());
  }

  setPasswordString(StorePassword key, String value) async {
    return _store.setString(key.toString(), value);
  }

  remove(StoreKeys key) async {
    return _store.remove(key.toString());
  }
}

