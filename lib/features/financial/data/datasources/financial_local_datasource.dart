import 'package:flutterarch/features/financial/data/models/expense_model.dart';

abstract class FinancialLocalDatasource {
  Future<List<ExpenseModel>> getExpenses();
  Future<void> saveExpense(ExpenseModel expense);
  Future<void> clearAllPaymentStatus();
}
