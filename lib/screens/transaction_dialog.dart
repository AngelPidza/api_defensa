import 'package:api_defensa/api_bloc/api_bloc/api_bloc.dart';
import 'package:api_defensa/api_bloc/api_bloc/api_event.dart';
import 'package:api_defensa/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDialog extends StatefulWidget {
  final Transaction? transaction;

  const TransactionDialog({super.key, this.transaction});

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  late TextEditingController nameController;
  late TextEditingController amountController;
  late bool status;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.transaction?.name ?? '');
    amountController = TextEditingController(
        text: widget.transaction?.amount.toString() ?? '');
    status = widget.transaction?.status ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.transaction == null
          ? 'Nueva Transacción'
          : 'Editar Transacción'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Monto'),
            keyboardType: TextInputType.number,
          ),
          SwitchListTile(
            title: const Text('Estado'),
            value: status,
            onChanged: (value) => setState(() => status = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final transaction = Transaction(
              id: widget.transaction?.id ?? '',
              name: nameController.text,
              amount: double.tryParse(amountController.text) ?? 0,
              status: status,
              avatar: 'https://example.com/avatar.png',
              paymentMethod: 'default',
              transactionDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            );

            if (widget.transaction == null) {
              context.read<ApiBloc>().add(AddTransaction(transaction));
            } else {
              context.read<ApiBloc>().add(UpdateTransaction(transaction));
            }

            Navigator.pop(context);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
