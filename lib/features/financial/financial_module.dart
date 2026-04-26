import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutterarch/features/financial/binds/financial_binds.dart';
import 'package:flutterarch/features/financial/presentation/cubits/financial_cubit.dart';
import 'package:flutterarch/features/financial/presentation/pages/financial_page.dart';

class FinancialModule {
  static final GetIt _getIt = GetIt.instance;

  /// Inicializar todas as dependências do módulo
  static void setup() {
    FinancialBinds.setupBinds(_getIt);
  }

  /// Retornar a página financeira com o Cubit injetado
  static Widget getFinancialPage() {
    return BlocProvider<FinancialCubit>(
      create: (context) => _getIt<FinancialCubit>(),
      child: const FinancialPage(),
    );
  }
}
