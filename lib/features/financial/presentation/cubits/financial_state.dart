import 'package:equatable/equatable.dart';
import 'package:flutterarch/features/financial/domain/entities/expense_entity.dart';

abstract class FinancialState extends Equatable {
  const FinancialState();

  @override
  List<Object?> get props => [];
}

class FinancialInitial extends FinancialState {
  const FinancialInitial();
}

class FinancialLoading extends FinancialState {
  const FinancialLoading();
}

class FinancialLoaded extends FinancialState {
  final List<ExpenseEntity> expenses;
  final int paidCount;
  final double totalAmount;
  final double paidAmount;

  const FinancialLoaded({
    required this.expenses,
    required this.paidCount,
    required this.totalAmount,
    required this.paidAmount,
  });

  @override
  List<Object?> get props => [expenses, paidCount, totalAmount, paidAmount];
}

class FinancialError extends FinancialState {
  final String message;

  const FinancialError({required this.message});

  @override
  List<Object?> get props => [message];
}
