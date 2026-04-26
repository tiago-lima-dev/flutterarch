import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final String id;
  final String name;
  final double amount;
  final bool isPaid;
  final String? paymentType; // 'cartão', 'dinheiro', null
  final DateTime createdAt;

  const ExpenseEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.isPaid,
    this.paymentType,
    required this.createdAt,
  });

  // Método para copiar com mudanças
  ExpenseEntity copyWith({
    String? id,
    String? name,
    double? amount,
    bool? isPaid,
    String? paymentType,
    DateTime? createdAt,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      isPaid: isPaid ?? this.isPaid,
      paymentType: paymentType ?? this.paymentType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, amount, isPaid, paymentType, createdAt];
}
