import 'package:flutterarch/features/financial/domain/entities/expense_entity.dart';
import 'package:flutterarch/features/financial/domain/repositories/financial_repository.dart';

class UpdateExpenseUseCase {
  final FinancialRepository repository;

  UpdateExpenseUseCase({required this.repository});

  Future<void> call(ExpenseEntity expense) async {
    return await repository.updateExpense(expense);
  }
}
