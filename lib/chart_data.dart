import './chart.dart';

import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';

class ChartData extends StatelessWidget {
  List<Transactions> tx;

  ChartData(this.tx);
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final week = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0;
      for (var i = 0; i < tx.length; i++) {
        if (tx[i].date.day == week.day &&
            tx[i].date.month == week.month &&
            tx[i].date.year == week.year) {
          totalAmount += tx[i].amount;
        }
      }

      return {'day': DateFormat.E().format(week), 'amount': totalAmount};
    }).reversed.toList();
  }

  double get weeklyAmount {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
        
        elevation: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactions.map((map) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: Chart(map['amount'],
                        weeklyAmount==0? 0.0 : (map['amount'] as double) / weeklyAmount, map['day']));
              }).toList()),
  
      
    );
  }
}
