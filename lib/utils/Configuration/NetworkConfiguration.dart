class NetworkConfiguration {
  NetworkConfiguration._privateConstructor();
  static final NetworkConfiguration _instance =
      NetworkConfiguration._privateConstructor();
  factory NetworkConfiguration() => _instance;

  String address = 'http://thefircoffe.ddns.net:5050';
  Map controllersMap = {
    'history_orders': '/controllers/history_orders',
    'active_orders': '/controllers/active_orders',
    'orders': "controllers/orders",
    'coffes': "/controllers/coffes",
    'coffe': "/controllers/coffe",
    'coffehouse': "/controllers/coffehouse",
    'upload_file': "/upload_file",
    'delete_file': "/delete_file",
    'update_coffe_house': '/coffehouse/update_coffe_house',
    'create_coffe': '/coffehouse/create_coffe',
    'coffe_get': '/coffehouse/get_coffe',
    'coffe_delete': '/coffehouse/delete_coffe',
  };
}
