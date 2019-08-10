import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transactions.dart';

class TextInputs extends StatefulWidget {
  final Function addExpense;

  TextInputs(this.addExpense);

  @override
  _TextInputsState createState() => _TextInputsState();
}

class _TextInputsState extends State<TextInputs> {
  final titleControllers = TextEditingController();
  DateTime transactionDate;
  final amountControllers = TextEditingController();

  void datePicker(BuildContext ctx) {
    showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((DateTime dt) {
      if (dt == null) {
        return;
      }

      setState(() {
        transactionDate = dt;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 20.0,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hoverColor: Colors.grey,
                    labelText: 'Title',
                    labelStyle: Theme.of(context).textTheme.body1.apply(
                        color: Theme.of(context).accentColor,
                        fontSizeFactor: 1.5,
                        fontWeightDelta: 7)),
                controller: titleControllers,
                onSubmitted: (_) {
                  addTransaction();
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: Theme.of(context).textTheme.body1.apply(
                        color: Theme.of(context).accentColor,
                        fontSizeFactor:
                            1.5 * MediaQuery.of(context).textScaleFactor,
                        fontWeightDelta: 7)),
                controller: amountControllers,
                onSubmitted: (_) {
                  addTransaction();
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date: ',
                    style: Theme.of(context).textTheme.body1.apply(
                        fontWeightDelta: 20,
                        fontSizeFactor:
                            1.4 * MediaQuery.of(context).textScaleFactor,
                        color: Theme.of(context).accentColor),
                  ),
                  Text(
                    transactionDate == null
                        ? ' No Date Chosen'
                        : ' ${DateFormat.yMMMd().format(transactionDate)}',
                    style: Theme.of(context).textTheme.body1.apply(
                        fontWeightDelta: 20,
                        fontSizeFactor:
                            1.2 * MediaQuery.of(context).textScaleFactor),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20 *
                                      MediaQuery.of(context).textScaleFactor, 
                                      fontWeight: FontWeight.bold),
                             
                            ),
                            onPressed: () {
                              datePicker(context);
                            },
                          )
                        : FlatButton(
                            child: Text(
                              'Choose Date',
                              style: Theme.of(context).textTheme.body1.apply(
                                  color: Theme.of(context).primaryColor,
                                  fontWeightDelta: 20,
                                  fontSizeFactor: 1.3 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                            onPressed: () {
                              datePicker(context);
                            },
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),

              Platform.isIOS
                        ? CupertinoButton(
                          color: Theme.of(context).primaryColor,
                            child: Text(
                              'Add Expense',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20 *
                                      MediaQuery.of(context).textScaleFactor, 
                                      fontWeight: FontWeight.bold),
                             
                            ),
                            onPressed: () {
                             addTransaction();
                            },
                          )
                        : 
              FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add Expense',
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .apply(color: Colors.white),
                ),
                onPressed: () {
                  addTransaction();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void addTransaction() {
    if (titleControllers.text != '' &&
        double.parse(amountControllers.text) >= 0 &&
        transactionDate != null) {
      var tx = Transactions(
          amount: double.parse(
              num.parse(amountControllers.text).toStringAsFixed(2)),
          date: transactionDate,
          title: titleControllers.text);
      widget.addExpense(tx);
      Navigator.of(context).pop();
    }
  }
}
