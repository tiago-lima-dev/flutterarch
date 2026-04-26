import 'package:flutterarch/features/financial/domain/entities/expense_entity.dart';
import 'package:flutterarch/features/financial/domain/repositories/financial_repository.dart';

class GetExpensesUseCase {
  final FinancialRepository repository;

  GetExpensesUseCase({required this.repository});

  Future<List<ExpenseEntity>> call() async {
    return await repository.getExpenses();
  }
}
