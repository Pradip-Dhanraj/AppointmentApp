const String devUrl = 'http://192.168.1.8:3000';
const String prodUrl = '';

environment appEnvironment = environment.DEV;

String get url {
  if (environment.DEV == appEnvironment) {
    return devUrl;
  } else {
    return prodUrl;
  }
}

enum environment {
  PROD,
  DEV,
}
