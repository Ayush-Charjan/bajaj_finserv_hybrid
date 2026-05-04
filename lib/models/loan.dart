// Loan model to represent loan details
class Loan {
  final String id;
  final String type;
  final double amount;
  final double interestRate;
  final int tenure; // in months
  final double emiAmount;
  final String status; // active, closed, pending
  final DateTime startDate;

  Loan({
    required this.id,
    required this.type,
    required this.amount,
    required this.interestRate,
    required this.tenure,
    required this.emiAmount,
    required this.status,
    required this.startDate,
  });
}
