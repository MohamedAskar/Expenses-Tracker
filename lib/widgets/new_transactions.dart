import '../widgets/AdaptiveFlatButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function newTransactionsHandler;

  NewTransactions(this.newTransactionsHandler);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _dateTime;

  void _submitData() {
    final enteredTitle = _titleController.text;
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _dateTime == null) {
      return;
    }
    widget.newTransactionsHandler(enteredTitle, enteredAmount, _dateTime);

    Navigator.of(context).pop();
  }

  void _persentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData()),
            TextField(
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _dateTime == null
                          ? 'No Date Choosen yet!'
                          : 'Picked Date: ${DateFormat.yMMMd().format(_dateTime)}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  AdaptiveFlatButton('Choose Date', _persentDatePicker)
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Add Transaction',
              ),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
