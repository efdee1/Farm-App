import 'package:body1/models/sales.dart';
import 'package:body1/models/sell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesDetailPage extends StatelessWidget {
  final Sales  sales;



  const SalesDetailPage({Key key, @required this.sales}) : super(key: key);@override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Detail',
          style: TextStyle(
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Card(
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
          color: Colors.lightGreen,
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(

          padding: const EdgeInsets.fromLTRB(18,0,277,0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(sales.title,
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 10.0,),
              Text('price: \$${sales.price}\n\namount: ${sales.amount} \n\ntotalsale: \$${sales.totalsale}',

                style: TextStyle(
                    fontSize: 16.0,
                  color: Colors.white

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
