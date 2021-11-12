import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTranscationValues {
    // 取得過去一週的時間並將對應的內容包裝
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var tx in recentTransactions) {
        if (tx.date.year == weekDay.year &&
            tx.date.month == weekDay.month &&
            tx.date.day == weekDay.day) {
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTranscationValues);


    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
