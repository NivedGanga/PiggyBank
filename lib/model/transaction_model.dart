

class TransactionModel {
  String id;

  final String purpose;

  final String amount;

  final String date;

  final String category;

  TransactionModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.category,
      required this.id});
  @override
  String toString() {
    return '$purpose $amount $date $category';
  }
}
