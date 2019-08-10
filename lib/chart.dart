import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final daysExpenses;
  final percExpenses;
  final weekday;

  Chart(this.daysExpenses, this.percExpenses, this.weekday);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){

      return Column(children: <Widget>[
      Container (
          height: constraints.maxHeight*0.13,
          child: FittedBox(
              child: Text('\$${daysExpenses.toString()}',
        style: Theme.of(context).textTheme.body2,
      ))),
      RotatedBox(
        quarterTurns: 2,
              child: Container(
          
          height: constraints.maxHeight*0.65,
          width: constraints.maxWidth*0.3,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(81, 81, 81, 0.2),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.0)),
              ),
              FractionallySizedBox(
                heightFactor: percExpenses,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color: Color.fromRGBO(46, 22, 201, 1),
                        style: BorderStyle.solid,
                        width: 1.0,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: constraints.maxHeight*0.05,
      ),
      Text(
        weekday,
        style: Theme.of(context).textTheme.body2,
      ),
    ]);
    });
     
  }
}
