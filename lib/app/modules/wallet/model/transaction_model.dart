class Transaction {
  int id;
  num amount;
  String type;
  String description;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      amount: num.parse(json['amount'].toString()),
      type: json['type'] as String,
      description: json['description'] as String,
    );
  }
}

class TransactionData {
  List<Transaction> transactions;

  TransactionData({
    required this.transactions,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    final transactionsList = (json['transactions']['data'] as List)
        .map((transactionJson) => Transaction.fromJson(transactionJson))
        .toList();

    return TransactionData(
      transactions: transactionsList,
    );
  }
}

final List<Transaction> transactions1 = [
  Transaction(
    id: 1,
    amount: 100.0,
    type: "إيداع",
    description: "تم إضافة رصيد إلى محفظتك",
  ),
  Transaction(
    id: 2,
    amount: -50.0,
    type: "سحب",
    description: "تم سحب الرصيد من محفظتك",
  ),
  Transaction(
    id: 2,
    amount: 50.0,
    type: "خصم",
    description: "تم خصم الرصيد من محفظتك",
  ),
];

final TransactionData transactionData1 = TransactionData(
  transactions: transactions1,
);
