/// Get Configuration of app
class AppConfig {
  /// Get app name
  appName() {
    return "Choco TV";
  }

  /// Get app slogan
  appSlogan() {
    return "Watch what you want";
  }

  /// Get backend api url
  apiUrl() {
    //return "http://192.168.10.235/pharmacy-web/public/api";
    //return "http://192.168.10.235/api";
    return "http://enigmatic-coast-30495.herokuapp.com/api";
  }

  /// Get backend api url
  apiBaseUrl() {
    //return "http://localhost/pharmacy-web/public";
    //return "http://192.168.10.235";
    return "http://enigmatic-coast-30495.herokuapp.com";
  }
}
