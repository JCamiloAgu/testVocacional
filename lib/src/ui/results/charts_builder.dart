import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:testvocacional/src/models/graphics_item_model.dart';

class ChartsBuilder {
  Widget build(String title, List<GraphicsItemModel> data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Center(
                child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )),
            Container(
              width: double.infinity,
              height: 300,
              child: charts.BarChart(
                _createSampleData(data),
                vertical: false,
                primaryMeasureAxis: _getPrimaryMeasureAxis(),
                barRendererDecorator: charts.BarLabelDecorator<String>(),
                domainAxis:
                    charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<charts.Series<GraphicsItemModel, String>> _createSampleData(
      List<GraphicsItemModel> data) {
    return [
      charts.Series<GraphicsItemModel, String>(
          id: 'Graphics',
          domainFn: (GraphicsItemModel model, _) => model.domain,
          measureFn: (GraphicsItemModel model, _) => model.measure,
          data: (!isNullOrEmpty(data))
              ? data
              : [GraphicsItemModel(domain: '', measure: 0)],
          fillColorFn: (datum, index) => charts.Color.fromHex(code: '#ff6b00'),
          labelAccessorFn: (GraphicsItemModel data, _) =>
              '${data.domain}: ${data.measure}%')
    ];
  }

  charts.NumericAxisSpec _getPrimaryMeasureAxis() {
    return charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
            labelStyle:
                charts.TextStyleSpec(color: charts.MaterialPalette.black),
            lineStyle: charts.LineStyleSpec(
                color: charts.MaterialPalette.gray.shade400)));
  }

  bool isNullOrEmpty(List<GraphicsItemModel> data) =>
      data == null || data.isEmpty;
}
