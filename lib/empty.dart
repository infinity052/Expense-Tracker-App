import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  AppBar appBar;

  Empty(this.appBar);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.of(context).size.height-appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top,
        child: Column(
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: Image.asset('assets/images/empty.jpg')),
            Text(
              'No Expenses added yet!',
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
