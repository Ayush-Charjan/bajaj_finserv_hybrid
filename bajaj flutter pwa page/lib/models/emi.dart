// EMI model to represent EMI card details
class EMI {
  final String id;
  final String loanType;
  final double emiAmount;
  final DateTime dueDate;
  final bool isPaid;
  final int remainingEmis;

  EMI({
    required this.id,
    required this.loanType,
    required this.emiAmount,
    required this.dueDate,
    required this.isPaid,
    required this.remainingEmis,
  });
}
