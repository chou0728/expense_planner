// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_flat_button.dart';
import '../widgets/adaptive_raised_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  State<NewTransaction> createState() {
    print('createState NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    /**
     * 在這邊可以發起一些http request
     * super是引用parent class State
     * 只會被調用一次
     */
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    /**
     * 當有些資料更改了，要去改動可以在這邊調用
     */
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  void dispose() {
    /**
     * 當 widget 被remove時
     * clear listener or real time connection
     */
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          _selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date: ${DateFormat('yyyy/MM/dd').format(_selectedDate)}',
                        ),
                      ),
                      AdaptiveFlatButton('Choose Date', _presentDatePicker)
                    ],
                  ),
                ),
                AdaptiveRaisedButton('Add Transaction', _submitData)
              ],
            ),
          )),
    );
  }
}
