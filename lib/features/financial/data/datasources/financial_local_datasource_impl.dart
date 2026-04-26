import 'package:flutterarch/features/financial/data/datasources/financial_local_datasource.dart';
import 'package:flutterarch/features/financial/data/models/expense_model.dart';

class FinancialLocalDatasourceImpl implements FinancialLocalDatasource {
  // Mock data - simula dados do banco/storage local
  static final List<ExpenseModel> _mockExpenses = [
    ExpenseModel(
      id: '1',
      name: 'Internet',
      amount: 149.00,
      isPaid: false,
      paymentType: null,
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '2',
      name: 'Vivo',
      amount: 60.00,
      isPaid: false,
      paymentType: null,
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '3',
      name: 'Casa',
      amount: 1680.00,
      isPaid: false,
      paymentType: null,
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '4',
      name: 'Blusa',
      amount: 1000.00,
      isPaid: false,
      paymentType: 'cartão',
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '5',
      name: 'Macmini',
      amount: 290.00,
      isPaid: false,
      paymentType: 'cartão',
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '6',
      name: 'Médico',
      amount: 207.00,
      isPaid: false,
      paymentType: 'cartão',
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '7',
      name: 'Limpeza casa',
      amount: 300.00,
      isPaid: false,
      paymentType: null,
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '8',
      name: 'Energia',
      amount: 350.00,
      isPaid: false,
      paymentType: null,
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '9',
      name: 'Água',
      amount: 190.00,
      isPaid: false,
      paymentType: null,
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '10',
      name: 'IPTU',
      amount: 350.00,
      isPaid: false,
      paymentType: null,
      createdAt: DateTime.now(),
    ),
    ExpenseModel(
      id: '11',
      name: 'IR',
      amount: 400.00,
      isPaid: false,
      paymentType: null,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    // Simular delay de carregamento
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_mockExpenses);
  }

  @override
  Future<void> saveExpense(ExpenseModel expense) async {
    // Simular delay de salvamento
    await Future.delayed(const Duration(milliseconds: 200));
    
    final index = _mockExpenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _mockExpenses[index] = expense;
    } else {
      _mockExpenses.add(expense);
    }
  }

  @override
  Future<void> clearAllPaymentStatus() async {
    // Simular delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Desmarcar todos como pagos
    _mockExpenses.replaceRange(
      0,
      _mockExpenses.length,
      _mockExpenses.map((e) => e.copyWith(isPaid: false)).toList(),
    );
  }
}
