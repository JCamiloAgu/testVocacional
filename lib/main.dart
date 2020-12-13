import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/routes/routes.dart' as routes;
import 'package:testvocacional/src/services/aptitudes_services.dart';
import 'package:testvocacional/src/services/intereses_service.dart';
import 'package:testvocacional/src/ui/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AptitudesServices(),),
        ChangeNotifierProvider(create: (_) => InteresesService(),)
      ],
      child: MaterialApp(
          title: 'PRUEBA DE ORIENTACIÓN VOCACIONAL',
          debugShowCheckedModeBanner: false,
          initialRoute: HomePage.ROUTE_NAME,
          routes: routes.getApplicationRoutes(),
          onUnknownRoute: (settings) => MaterialPageRoute(
                builder: (context) => HomePage(),
              )),
    );
  }
}
