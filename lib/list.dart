import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';

class Lists extends StatelessWidget {
  final List<Transactions> tx;
  Lists(this.tx, this.deleteEntry);
  Function deleteEntry;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 30.0,
              child: Container(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.purple,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '\$${tx[index].amount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  20.0 * MediaQuery.of(context).textScaleFactor,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tx[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            25.0 * MediaQuery.of(context).textScaleFactor),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(tx[index].date),
                    style: TextStyle(),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          label: Text('Delete'),
                          icon: Icon(Icons.delete),
                          textColor: Colors.red,
                          onPressed: () {
                            deleteEntry(index);
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteEntry(index);
                          },
                        ),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: tx.length,
    );
  }
}
