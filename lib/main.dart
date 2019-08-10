import 'dart:io';
import 'package:expense_tracker/orientations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './textinputs.dart';
import './transactions.dart';
import './empty.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS? CupertinoApp(
      title: 'Expense Tracker',
      theme: CupertinoThemeData(
        primaryColor: Colors.lightGreen,
        // primaryColorBrightness: Brightness.dark,\
        brightness: Brightness.light,
        // accentColor: Colors.red,
        
        // accentColorBrightness: Brightness.dark,
        
      ),
      home: MyApp(),

    ):
    
    MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.red,
        accentColorBrightness: Brightness.dark,
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              fontFamily: 'Karla',
            ),
            body2: TextStyle(
              fontFamily: 'Karla',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: 'EB Garmond',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ))),
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showChart = false;
  static List<Transactions> transactions = [];

  void newTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: TextInputs(addExpense),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void addExpense(Transactions value) {
    setState(() {
      transactions.add(value);
    });
  }

  void showChartSwitch(val) {
    setState(() {
      showChart = val;
    });
  }

  void deleteEntry(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Tracker', style: TextStyle(fontFamily: 'EB Garmond', fontWeight: FontWeight.bold),),

            trailing: Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => newTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text("Expense Tracker"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => newTransaction(context),
              )
            ],
          );
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final body = (SafeArea(
        child: SingleChildScrollView(
            child: transactions.isEmpty
                ? Empty(appBar)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Orientations(
                          deleteEntry: deleteEntry,
                          isLandscape: isLandscape,
                          showChart: showChart,
                          showChartSwitch: showChartSwitch,
                          transactions: transactions,
                          appBar: appBar,
                        ),
                      ]))));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: body,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => newTransaction(context),
                    elevation: 20.0,
                  ),
          );
  }
}
