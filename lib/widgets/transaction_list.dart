import '../models/Transactions.dart';
import 'package:flutter/material.dart';
import './transactions_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;

  final Function delete;

  TransactionList(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraint) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    height: constraint.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'No Transactions added yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(transaction: transactions[index], delete: delete);
            },
            itemCount: transactions.length,
          );
  }
}

