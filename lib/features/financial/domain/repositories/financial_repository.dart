import 'package:flutterarch/features/financial/domain/entities/expense_entity.dart';

abstract class FinancialRepository {
  Future<List<ExpenseEntity>> getExpenses();
  Future<void> updateExpense(ExpenseEntity expense);
  Future<void> clearAllPaymentStatus();
}
