class AppConfig{

  String displayVersion = 'V1.1.0';
  String displayBuild = 'Build 20221122';

  String baseIP = '192.168.8.1';
  int basePort = 8080;

  AppConfig._();

  static AppConfig _instance = AppConfig._();

  static AppConfig getInstance() => _instance;
}