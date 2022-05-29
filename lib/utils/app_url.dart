class AppUrl {
  static const String liveBaseURL = "https://shiny-awful-wildebeast.gigalixirapp.com/api/v1";
  // static const String localBaseURL = "http://10.0.2.2:4000/api/v1";
  static const String localBaseURL = "http://127.0.0.1";

  static const dynamic baseURL = liveBaseURL;
  static const dynamic login = baseURL + "/session";
  static const dynamic register = baseURL + "/registration";
  // static const String forgotPassword = baseURL + "/forgot-password";
}