import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            color: Theme.of(context).primaryColorLight,
            child: Column(
              children: [
                Text('Datos personales', style: TextStyle(fontSize: 24)),
                Text('Sección 1 de 6')
              ],
            ),
          ),
          SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(getDescription()),
          )
        ],
      ),
    );
  }

  String getDescription() {
    return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris viverra porta quam vel fringilla. Fusce sed facilisis justo, et pretium arcu. Nam et ante in nibh hendrerit aliquam. Suspendisse potenti. Sed elementum et arcu a pretium. Nunc tincidunt erat ut consectetur porttitor. Mauris gravida, risus sit amet rutrum vehicula, mauris diam facilisis nisl, eu fermentum nulla metus at orci. Integer et mattis purus. Donec tempor tristique enim nec tempus. Mauris aliquet rhoncus mollis. Etiam eu ornare quam. Suspendisse ultricies arcu et diam euismod fermentum. Donec justo massa, vehicula ac augue nec, dignissim ullamcorper magna. Donec dictum, ligula a finibus gravida, risus dolor feugiat ante, eu cursus quam ex vel neque. Donec varius fermentum sapien, a finibus ipsum pulvinar et. Proin venenatis condimentum facilisis.';
  }
}
