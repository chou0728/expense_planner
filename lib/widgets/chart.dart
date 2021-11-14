import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';
import './chart_bar.dart';

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
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
    // 用reversed的話，會變成 ReversedListIterable 型態，所以還要用 toList 轉回List型態
  }

  double get totalSpending {
    return groupedTranscationValues.fold(
        0.0, (acc, cur) => acc + cur['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTranscationValues);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTranscationValues
              .map(
                (value) => Flexible(
                  // 因為上層Row設了spaceAround，這邊再設定tight，這樣就不會超過每個數量平均下來的空間
                  fit: FlexFit.tight,
                  child: ChartBar(
                      value['day'],
                      value['amount'],
                      totalSpending == 0.0
                          ? 0.0
                          : (value['amount'] as double) / totalSpending),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
