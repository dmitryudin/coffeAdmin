class NetworkConfiguration {
  NetworkConfiguration._privateConstructor();
  static final NetworkConfiguration _instance =
      NetworkConfiguration._privateConstructor();
  factory NetworkConfiguration() => _instance;

  String address = 'http://thefir.ddns.net:5050';
  Map controllersMap = {
    'coffehouse_get': "/coffehouse/get_coffe_house",
    'delete_file': "/delete_file",
    'upload_file': "/upload_file",
    'update_coffe_house': '/coffehouse/update_coffe_house',
    'create_coffe': '/coffehouse/create_coffe',
    'coffe_get': '/coffehouse/get_coffe',
    'coffe_delete': '/coffehouse/delete_coffe',
  };
}
