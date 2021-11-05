// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
              ),
              FlatButton(
                onPressed: () => addNewTransaction(
                    titleController.text, double.parse(amountController.text)),
                child: Text('Add Transaction',
                    style: TextStyle(
                      color: Colors.blue,
                    )),
              )
            ],
          ),
        ));
  }
}