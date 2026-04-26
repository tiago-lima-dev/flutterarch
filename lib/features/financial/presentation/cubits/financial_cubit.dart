import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterarch/features/financial/domain/entities/expense_entity.dart';
import 'package:flutterarch/features/financial/domain/usecases/clear_all_usecase.dart';
import 'package:flutterarch/features/financial/domain/usecases/get_expenses_usecase.dart';
import 'package:flutterarch/features/financial/domain/usecases/update_expense_usecase.dart';
import 'package:flutterarch/features/financial/presentation/cubits/financial_state.dart';

class FinancialCubit extends Cubit<FinancialState> {
  final GetExpensesUseCase getExpensesUseCase;
  final UpdateExpenseUseCase updateExpenseUseCase;
  final ClearAllUseCase clearAllUseCase;

  FinancialCubit({
    required this.getExpensesUseCase,
    required this.updateExpenseUseCase,
    required this.clearAllUseCase,
  }) : super(const FinancialInitial());

  Future<void> loadExpenses() async {
    try {
      emit(const FinancialLoading());
      final expenses = await getExpensesUseCase.call();
      _emitLoadedState(expenses);
    } catch (e) {
      emit(FinancialError(message: e.toString()));
    }
  }

  Future<void> toggleExpensePayment(ExpenseEntity expense) async {
    try {
      final updatedExpense = expense.copyWith(isPaid: !expense.isPaid);
      await updateExpenseUseCase.call(updatedExpense);
      
      // Recarregar a lista após atualizar
      await loadExpenses();
    } catch (e) {
      emit(FinancialError(message: e.toString()));
    }
  }

  Future<void> clearAllPayments() async {
    try {
      await clearAllUseCase.call();
      
      // Recarregar a lista após limpar
      await loadExpenses();
    } catch (e) {
      emit(FinancialError(message: e.toString()));
    }
  }

  void _emitLoadedState(List<ExpenseEntity> expenses) {
    final paidCount = expenses.where((e) => e.isPaid).length;
    final totalAmount = expenses.fold<double>(0, (sum, e) => sum + e.amount);
    final paidAmount = expenses
        .where((e) => e.isPaid)
        .fold<double>(0, (sum, e) => sum + e.amount);

    emit(FinancialLoaded(
      expenses: expenses,
      paidCount: paidCount,
      totalAmount: totalAmount,
      paidAmount: paidAmount,
    ));
  }
}
