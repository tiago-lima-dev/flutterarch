import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterarch/features/financial/presentation/cubits/financial_cubit.dart';
import 'package:flutterarch/features/financial/presentation/cubits/financial_state.dart';

class FinancialPage extends StatefulWidget {
  const FinancialPage({super.key});

  @override
  State<FinancialPage> createState() => _FinancialPageState();
}

class _FinancialPageState extends State<FinancialPage> {
  @override
  void initState() {
    super.initState();
    context.read<FinancialCubit>().loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financeiro Março'),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[850],
      body: BlocBuilder<FinancialCubit, FinancialState>(
        builder: (context, state) {
          if (state is FinancialLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FinancialLoaded) {
            return Column(
              children: [
                // Header com resumo
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[900],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.paidCount}/${state.expenses.length} concluídos',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'R\$ ${state.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Pagos',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'R\$ ${state.paidAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Lista de despesas
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    itemCount: state.expenses.length,
                    itemBuilder: (context, index) {
                      final expense = state.expenses[index];
                      return _ExpenseCard(expense: expense);
                    },
                  ),
                ),
              ],
            );
          } else if (state is FinancialError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar despesas',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FinancialCubit>().loadExpenses();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: BlocBuilder<FinancialCubit, FinancialState>(
        builder: (context, state) {
          if (state is FinancialLoaded && state.paidCount > 0) {
            return FloatingActionButton(
              onPressed: () {
                _showClearConfirmDialog(context);
              },
              backgroundColor: Colors.red[700],
              child: const Icon(Icons.refresh),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showClearConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.grey[800],
        title: const Text(
          'Limpar pagamentos',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Tem certeza que deseja desmarcar todos os itens como pagos?',
          style: TextStyle(color: Colors.grey[300] ?? Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<FinancialCubit>().clearAllPayments();
              Navigator.pop(dialogContext);
            },
            child: const Text(
              'Limpar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseCard extends StatelessWidget {
  final dynamic expense;

  const _ExpenseCard({required this.expense});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FinancialCubit>().toggleExpensePayment(expense);
      },
      child: Card(
        color: Colors.grey[800],
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Checkbox estilo círculo
              GestureDetector(
                onTap: () {
                  context.read<FinancialCubit>().toggleExpensePayment(expense);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: expense.isPaid ? Colors.greenAccent : Colors.grey,
                      width: 2,
                    ),
                    color: expense.isPaid ? Colors.greenAccent : Colors.transparent,
                  ),
                  child: expense.isPaid
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.black,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              // Nome e tipo de pagamento
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.name,
                      style: TextStyle(
                        color: expense.isPaid ? Colors.grey : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: expense.isPaid
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    if (expense.paymentType != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          expense.paymentType,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Valor
              Text(
                'R\$ ${expense.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: expense.isPaid ? Colors.greenAccent : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: expense.isPaid
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
