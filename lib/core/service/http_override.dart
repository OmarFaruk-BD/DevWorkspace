import 'dart:io';

//  HttpOverrides.global = MyHttpOverrides();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// void _initializeHttpClient() {
//   _dio.httpClientAdapter = IOHttpClientAdapter(
//     createHttpClient: () {
//       final client = HttpClient(
//         context: SecurityContext(withTrustedRoots: false),
//       );
//       client.badCertificateCallback = (cert, host, port) => true;
//       return client;
//     },
//   );
// }
