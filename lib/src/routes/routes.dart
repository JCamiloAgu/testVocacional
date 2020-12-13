import 'package:flutter/cupertino.dart';
import 'package:testvocacional/src/ui/home/home_page.dart';
import 'package:testvocacional/src/ui/question_page/question_page.dart';
import 'package:testvocacional/src/ui/results/results_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
      HomePage.ROUTE_NAME: (BuildContext context) => HomePage(),
      QuestionPage.ROUTE_NAME: (BuildContext context) => QuestionPage(),
      ResultsPage.ROUTE_NAME: (BuildContext context) => ResultsPage(),
    };
