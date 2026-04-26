# 💰 FlutterArch - Gerenciador de Despesas

Um aplicativo Flutter com Clean Architecture para gerenciar despesas mensais usando **Cubit** para state management.

## 📋 O que foi Feito

### ❌ Removido
- Feature `benefits` completa (todos os arquivos)
- Documentação da feature anterior
- Referências de benefits em `main.dart`

### ✅ Criado
- Nova feature `financial` com estrutura completa
- Cubit para gerenciamento de estado (alternativa a BLoC)
- 11 despesas mockadas (Internet, Vivo, Casa, etc)
- UI em tema escuro profissional
- Injeção de dependências com GetIt
- Persistência preparada com Hive

## 🏗️ Estrutura de Pastas

```
lib/features/financial/
├── presentation/
│   ├── pages/
│   │   └── financial_page.dart
│   └── cubits/
│       ├── financial_cubit.dart
│       └── financial_state.dart
├── domain/
│   ├── entities/
│   │   └── expense_entity.dart
│   ├── repositories/
│   │   └── financial_repository.dart
│   └── usecases/
│       ├── get_expenses_usecase.dart
│       ├── update_expense_usecase.dart
│       └── clear_all_usecase.dart
├── data/
│   ├── models/
│   │   └── expense_model.dart
│   ├── datasources/
│   │   ├── financial_local_datasource.dart
│   │   └── financial_local_datasource_impl.dart
│   └── repositories/
│       └── financial_repository_impl.dart
├── binds/
│   └── financial_binds.dart
├── financial_module.dart
├── financial.dart
└── README.md
```

## 🎯 Funcionalidades

| Feature | Status | Descrição |
|---------|--------|-----------|
| Listar despesas | ✅ | Carrega lista completa |
| Marcar como pago | ✅ | Toggle com checkbox circular |
| Contador | ✅ | "X de Y concluídos" |
| Total | ✅ | Mostra R$ total e pagos |
| Limpar tudo | ✅ | FAB dinamico + dialog |
| Tema escuro | ✅ | Interface profissional |
| Mock data | ✅ | 11 despesas de exemplo |
| Persistência | ⏳ | Pronto com Hive |

## 🚀 Como Executar

### 1. Instalar Dependências

```bash
flutter pub get
```

### 2. Rodar a Aplicação

```bash
flutter run
```

### 3. Interagir

- **Clique no card** → Marcar/desmarcar como pago
- **FAB (botão flutuante)** → Limpar todos os pagamentos
- **Header** → Ver resumo de gastos

## 📊 Dados Mockados

A aplicação vem com 11 despesas pré-carregadas:

```
Internet       149.00
Vivo            60.00
Casa          1680.00  
Blusa         1000.00 (cartão)
Macmini        290.00 (cartão)
Médico         207.00 (cartão)
Limpeza        300.00
Energia        350.00
Água           190.00
IPTU           350.00
IR             400.00
```

**Total: R$ 5,866.00**

## 🧬 Arquitetura

### Padrão: Clean Architecture + Feature-Based

```
Domain Layer (Regras de Negócio)
    ↓
Data Layer (Infraestrutura)
    ↓
Presentation Layer (UI + Cubit)
```

### Fluxo de Dados

```
UI Click
  ↓
FinancialCubit.toggleExpensePayment()
  ↓
UpdateExpenseUseCase
  ↓
FinancialRepository (abstrata)
  ↓
FinancialRepositoryImpl
  ↓
FinancialLocalDatasource (mock)
  ↓
Salva em memória
  ↓
Reload com loadExpenses()
  ↓
Cubit emite novo state
  ↓
UI atualiza via BlocBuilder
```

## 💡 Padrões Implementados

- ✅ **Clean Architecture** - Separação em 3 camadas
- ✅ **Feature-Based** - Modularização por feature
- ✅ **Cubit** - State management simples e eficaz
- ✅ **Repository Pattern** - Abstração de dados
- ✅ **Usecase Pattern** - Lógica de negócio isolada
- ✅ **Dependency Injection** - GetIt para injeção
- ✅ **Equatable** - Comparação de objetos
- ✅ **Dark Theme** - Interface profissional

## 📦 Dependências

```yaml
# State Management
flutter_bloc: ^9.1.1

# Dependency Injection
get_it: ^9.2.1

# Utilities
equatable: ^2.0.8
dartz: ^0.10.1
intl: ^0.19.0

# Persistência (pronto)
hive: ^2.2.3
hive_flutter: ^1.1.0
```

## 🛠️ Estrutura de um Usecase

```dart
class GetExpensesUseCase {
  final FinancialRepository repository;

  GetExpensesUseCase({required this.repository});

  Future<List<ExpenseEntity>> call() async {
    return await repository.getExpenses();
  }
}
```

## 🎨 Estados Disponíveis

```dart
FinancialInitial     // Inicial
FinancialLoading     // Carregando
FinancialLoaded      // Carregado com sucesso
  - expenses         // Lista de despesas
  - paidCount        // Quantas estão pagas
  - totalAmount      // Total em reais
  - paidAmount       // Total pago
FinancialError       // Erro
```

## 📚 Próximos Passos

1. **Persistência com Hive** - Salvar dados localmente
2. **CRUD Completo** - Criar, editar, deletar despesas
3. **Filtros** - Por tipo, status, mês
4. **Ordenação** - Por nome, valor, status
5. **Categorias** - Agrupar despesas
6. **Gráficos** - Pizza chart de gastos
7. **Notificações** - Lembretes de pagamento
8. **Múltiplos Meses** - Timeline de despesas

## 📖 Documentação

Para mais detalhes sobre a feature, veja [lib/features/financial/README.md](lib/features/financial/README.md)

## ✨ Características Especiais

### UI em Tema Escuro
- Cores neutras (greys) para o background
- Accent verde para pagos
- Accent vermelho para ações destrutivas

### Checkbox Estilo Moderno
- Círculo vazio → não pago
- Círculo preenchido verde → pago
- Checkmark animado

### Layout Responsivo
- Header fixo com resumo
- Lista scrollável
- FAB dinâmico (só aparece quando necessário)

## 🚨 Troubleshooting

### GetIt Error
```
// Certifique-se de chamar setup() em main()
void main() {
  FinancialModule.setup();
  runApp(const MyApp());
}
```

### Despesas não carregam
```dart
@override
void initState() {
  super.initState();
  context.read<FinancialCubit>().loadExpenses();
}
```

### Estado não atualiza
```dart
// Use BlocBuilder ou BlocListener
BlocBuilder<FinancialCubit, FinancialState>(
  builder: (context, state) {
    if (state is FinancialLoaded) {
      return ListView(...);
    }
  },
)
```

## 📊 Estatísticas

- **Arquivos criados**: 19
- **Linhas de código**: ~1.500
- **Camadas**: 3 (Domain, Data, Presentation)
- **Padrões**: 7 (Clean Arch, Repository, Usecase, Cubit, DI, etc)
- **Despesas mockadas**: 11

## 🎯 Diferenças vs. Feature Anterior (Benefits)

| Aspecto | Benefits | Financial |
|---------|----------|-----------|
| State Mgmt | BLoC | Cubit ✨ |
| Operações | Get | Get, Update, Clear |
| UI | Material 3 claro | Dark theme |
| Dados | 4 items | 11 items |
| Persistência | Nenhuma | Hive ready |
| Foco | Benefícios corporativos | Despesas pessoais |

---

**Desenvolvido seguindo Clean Architecture + Feature-Based Pattern**

**Stack: Flutter + Dart + Cubit + GetIt + Hive**

Teste