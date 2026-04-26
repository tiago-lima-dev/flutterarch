import 'package:equatable/equatable.dart';
import 'package:flutterarch/features/financial/domain/entities/expense_entity.dart';

class ExpenseModel extends Equatable {
  final String id;
  final String name;
  final double amount;
  final bool isPaid;
  final String? paymentType;
  final DateTime createdAt;

  const ExpenseModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.isPaid,
    this.paymentType,
    required this.createdAt,
  });

  // Converter para Entity
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      name: name,
      amount: amount,
      isPaid: isPaid,
      paymentType: paymentType,
      createdAt: createdAt,
    );
  }

  // Criar a partir de Entity
  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      name: entity.name,
      amount: entity.amount,
      isPaid: entity.isPaid,
      paymentType: entity.paymentType,
      createdAt: entity.createdAt,
    );
  }

  // JSON serialization
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      isPaid: json['isPaid'] ?? false,
      paymentType: json['paymentType'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'isPaid': isPaid,
      'paymentType': paymentType,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  ExpenseModel copyWith({
    String? id,
    String? name,
    double? amount,
    bool? isPaid,
    String? paymentType,
    DateTime? createdAt,
  }) {
    return ExpenseModel(
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
