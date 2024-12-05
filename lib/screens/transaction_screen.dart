import 'package:api_defensa/api_bloc/transaction_bloc.dart';
import 'package:api_defensa/api_bloc/transaction_state.dart';
import 'package:api_defensa/screens/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class TransactionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Transacciones'),
//         elevation: 2,
//       ),
//       body: BlocBuilder<TransactionBloc, TransactionState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (state.error != null) {
//             return Center(child: Text('Error: ${state.error}'));
//           }

//           return ListView.builder(
//             itemCount: state.transactions.length,
//             itemBuilder: (context, index) {
//               final transaction = state.transactions[index];
//               return TransactionCard(transaction: transaction);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
