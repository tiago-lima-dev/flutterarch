import 'package:get_it/get_it.dart';
import 'package:flutterarch/features/financial/data/datasources/financial_local_datasource.dart';
import 'package:flutterarch/features/financial/data/datasources/financial_local_datasource_impl.dart';
import 'package:flutterarch/features/financial/data/repositories/financial_repository_impl.dart';
import 'package:flutterarch/features/financial/domain/repositories/financial_repository.dart';
import 'package:flutterarch/features/financial/domain/usecases/clear_all_usecase.dart';
import 'package:flutterarch/features/financial/domain/usecases/get_expenses_usecase.dart';
import 'package:flutterarch/features/financial/domain/usecases/update_expense_usecase.dart';
import 'package:flutterarch/features/financial/presentation/cubits/financial_cubit.dart';

class FinancialBinds {
  static void setupBinds(GetIt getIt) {
    // Registrar Datasources
    getIt.registerSingleton<FinancialLocalDatasource>(
      FinancialLocalDatasourceImpl(),
    );

    // Registrar Repositories
    getIt.registerSingleton<FinancialRepository>(
      FinancialRepositoryImpl(
        localDatasource: getIt<FinancialLocalDatasource>(),
      ),
    );

    // Registrar Usecases
    getIt.registerSingleton<GetExpensesUseCase>(
      GetExpensesUseCase(
        repository: getIt<FinancialRepository>(),
      ),
    );

    getIt.registerSingleton<UpdateExpenseUseCase>(
      UpdateExpenseUseCase(
        repository: getIt<FinancialRepository>(),
      ),
    );

    getIt.registerSingleton<ClearAllUseCase>(
      ClearAllUseCase(
        repository: getIt<FinancialRepository>(),
      ),
    );

    // Registrar Cubits
    getIt.registerSingleton<FinancialCubit>(
      FinancialCubit(
        getExpensesUseCase: getIt<GetExpensesUseCase>(),
        updateExpenseUseCase: getIt<UpdateExpenseUseCase>(),
        clearAllUseCase: getIt<ClearAllUseCase>(),
      ),
    );
  }
}
