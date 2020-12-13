import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testvocacional/src/services/aptitudes_services.dart';
import 'package:testvocacional/src/services/intereses_service.dart';
import 'package:testvocacional/src/ui/home/home_form/home_form_validations.dart';
import 'package:testvocacional/src/utils/utils.dart' as utils;

import 'home_form/home_form.dart';
import 'home_header.dart';

class HomePage extends StatelessWidget {
  static const ROUTE_NAME = 'home';

  @override
  Widget build(BuildContext context) {
    // Future.delayed(
    //     Duration.zero,
    //     () => utils.showAlertDialog(context,
    //         title: getDialogTitle(), message: getDialogMessage()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba de orientación vocacional'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Provider.of<InteresesService>(context, listen: false).loadIntereses();
        // await Provider.of<AptitudesServices>(context, listen: false).loadAptitudes();
      },child: Icon(Icons.add),),
      body: buildBody(),
    );
  }

  String getDialogTitle() => 'PRUEBA DE ORIENTACIÓN VOCACIONAL SENA';

  String getDialogMessage() {
    return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris viverra porta quam vel fringilla. Fusce sed facilisis justo, et pretium arcu. Nam et ante in nibh hendrerit aliquam. Suspendisse potenti. Sed elementum et arcu a pretium. Nunc tincidunt erat ut consectetur porttitor. Mauris gravida, risus sit amet rutrum vehicula, mauris diam facilisis nisl, eu fermentum nulla metus at orci. Integer et mattis purus. Donec tempor tristique enim nec tempus. Mauris aliquet rhoncus mollis. Etiam eu ornare quam. Suspendisse ultricies arcu et diam euismod fermentum. Donec justo massa, vehicula ac augue nec, dignissim ullamcorper magna. Donec dictum, ligula a finibus gravida, risus dolor feugiat ante, eu cursus quam ex vel neque. Donec varius fermentum sapien, a finibus ipsum pulvinar et. Proin venenatis condimentum facilisis.' +
        'Vestibulum aliquam enim non quam accumsan, vel semper tellus ornare. Suspendisse potenti. Integer porttitor viverra commodo. Sed accumsan tellus a ullamcorper viverra. Fusce pulvinar odio quis erat porttitor, quis suscipit magna porttitor. Maecenas sit amet magna vel quam rhoncus tempus. Integer sodales vitae nulla a pharetra. Pellentesque id neque malesuada, vestibulum eros ut, aliquam lorem. Suspendisse nec turpis non ex cursus malesuada. Vivamus imperdiet turpis justo, a imperdiet nunc varius eget. Sed vehicula pulvinar dolor, ut mattis eros luctus non.';
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [HomeHeader(), HomeForm(HomeFormValidations())],
      ),
    );
  }
}
