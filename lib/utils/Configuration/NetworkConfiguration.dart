class NetworkConfiguration {
  NetworkConfiguration._privateConstructor();
  static final NetworkConfiguration _instance =
      NetworkConfiguration._privateConstructor();
  factory NetworkConfiguration() => _instance;

  String address = 'http://2.59.41.249:5050';
  Map controllersMap = {
    'coffes': "/controller/coffes",
    'coffe': "/controller/coffe",
    'coffehouse': "/controllers/coffehouse",
    'upload_file': "/upload_file",
    'update_coffe_house': '/coffehouse/update_coffe_house',
    'create_coffe': '/coffehouse/create_coffe',
    'coffe_get': '/coffehouse/get_coffe',
    'coffe_delete': '/coffehouse/delete_coffe',
  };
}
