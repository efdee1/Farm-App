import 'package:body1/models/stocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StocksDetailPage extends StatelessWidget {
  final Stocks stocks;


  const StocksDetailPage({Key key, @required this.stocks}) : super(key: key);@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(stocks.title,
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.title.copyWith(
                 fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            const SizedBox(height: 10.0,),
            Text('price: \$${stocks.price},\namount: ${stocks.amount}',
              style: TextStyle(
                  fontSize: 16.0
              ),
            )
          ],
        ),
      ),
    );
  }
}
