// ignore_for_file: prefer_const_constructors
part of 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // jika ingin mengirim argument
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
      case '/changePass':
        return MaterialPageRoute(builder: (_) => ChangePass());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/mainPenerimaan':
        return MaterialPageRoute(builder: (_) => MainPenerimaan());
      case '/inputPenerimaan':
        return MaterialPageRoute(builder: (_) => InputPenerimaan(objParam: settings.arguments));
      case '/historyPenerimaan':
        return MaterialPageRoute(builder: (_) => HistoryPenerimaan(objParam: settings.arguments));
      case '/laporanPenerimaan':
        return MaterialPageRoute(builder: (_) => LaporanPenerimaan());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text('Error page')),
      );
    });
  }
}
