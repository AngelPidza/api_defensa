import 'package:api_defensa/api_bloc/api_bloc/api_bloc.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_event.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_state.dart';
import 'package:api_defensa/models/transaction.dart';
import 'package:api_defensa/screens/transaction_card.dart';
import 'package:api_defensa/screens/transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenApi extends StatelessWidget {
  const ScreenApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transacciones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showTransactionDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          return ListView.builder(
            itemCount: state.transactions.length,
            itemBuilder: (context, index) {
              final transaction = state.transactions[index];
              return TransactionCard(
                transaction: transaction,
                onEdit: () =>
                    _showTransactionDialog(context, transaction: transaction),
                onDelete: () => context
                    .read<ApiBloc>()
                    .add(DeleteTransaction(transaction.id)),
              );
            },
          );
        },
      ),
    );
  }

  // En el archivo donde muestras el diálogo:
  void _showTransactionDialog(BuildContext context,
      {Transaction? transaction}) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: BlocProvider.of<ApiBloc>(context),
        child: TransactionDialog(transaction: transaction),
      ),
    );
  }
}
