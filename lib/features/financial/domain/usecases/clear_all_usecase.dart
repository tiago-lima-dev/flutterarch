import 'package:flutterarch/features/financial/domain/repositories/financial_repository.dart';

class ClearAllUseCase {
  final FinancialRepository repository;

  ClearAllUseCase({required this.repository});

  Future<void> call() async {
    return await repository.clearAllPaymentStatus();
  }
}
