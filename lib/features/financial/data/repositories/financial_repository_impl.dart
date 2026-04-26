import 'package:flutterarch/features/financial/data/datasources/financial_local_datasource.dart';
import 'package:flutterarch/features/financial/data/models/expense_model.dart';
import 'package:flutterarch/features/financial/domain/entities/expense_entity.dart';
import 'package:flutterarch/features/financial/domain/repositories/financial_repository.dart';

class FinancialRepositoryImpl implements FinancialRepository {
  final FinancialLocalDatasource localDatasource;

  FinancialRepositoryImpl({required this.localDatasource});

  @override
  Future<List<ExpenseEntity>> getExpenses() async {
    try {
      final models = await localDatasource.getExpenses();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateExpense(ExpenseEntity expense) async {
    try {
      final model = ExpenseModel.fromEntity(expense);
      await localDatasource.saveExpense(model);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearAllPaymentStatus() async {
    try {
      await localDatasource.clearAllPaymentStatus();
    } catch (e) {
      rethrow;
    }
  }
}
