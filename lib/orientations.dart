import 'package:flutter/material.dart';
import './list.dart';
import './chart_data.dart';

class Orientations extends StatelessWidget {
List transactions;
Function deleteEntry;
Function showChartSwitch;
bool showChart;
bool isLandscape;
 AppBar appBar;
Orientations({this.deleteEntry,this.isLandscape,this.showChart,this.showChartSwitch,this.transactions,this.appBar});
  @override
  Widget build(BuildContext context) {
    
   
   
    var listHeight = isLandscape
        ? (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.65
        : (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.60;
    var chartHeight = isLandscape
        ? (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.50
        : (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.35;
    
     var chartCode=Container(
                height: chartHeight,
                child: ChartData(transactions));
    var listCode=  Container(
                height: listHeight,
                child: Lists(transactions, deleteEntry));

    return Column(
      children: <Widget>[
        if(isLandscape)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Show Chart',
                style: Theme.of(context).textTheme.title.apply(
                    fontSizeFactor:
                        1 * MediaQuery.of(context).textScaleFactor)),
            Switch.adaptive(
              value: showChart,
              onChanged: (val) {
                showChartSwitch(val);
              },
            )
          ],
        ),
        if(isLandscape)
        SizedBox(
          height: 20,
        ),
        if(isLandscape)
        showChart?
        chartCode
        :
        listCode,

        if(!isLandscape)
        chartCode,
        if(!isLandscape)
        listCode,

      ],
    );
  }
}
