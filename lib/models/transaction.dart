class Transaction {
  final String id;
  final String name;
  final String avatar;
  final String paymentMethod;
  final int transactionDate;
  final double amount;
  final bool status;

  Transaction({
    required this.id,
    required this.name,
    required this.avatar,
    required this.paymentMethod,
    required this.transactionDate,
    required this.amount,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      paymentMethod: json['payment_method'],
      transactionDate: json['transaction_date'],
      amount: json['amount'].toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'payment_method': paymentMethod,
      'transaction_date': transactionDate,
      'amount': amount,
      'status': status,
    };
  }
}
