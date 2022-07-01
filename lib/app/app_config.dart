class AppConfig{

  String displayVersion = '1.0.0';
  String displayBuild = 'build 20220701';

  AppConfig._();

  static AppConfig _instance = AppConfig._();

  static AppConfig getInstance() => _instance;
}