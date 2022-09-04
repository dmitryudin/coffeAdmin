class KeyStorage {
  static final KeyStorage _keyStorage = KeyStorage._instance();
  Map<String, dynamic> keyStore = {'index': 0, 'order_srcoll_position': 0};

  factory KeyStorage() {
    return _keyStorage;
  }
  KeyStorage._instance();
}
