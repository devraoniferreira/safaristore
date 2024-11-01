import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safaristore/blocs/records_bloc.dart';
import 'package:safaristore/services/api_service.dart';

class RecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecordsBloc(apiService: ApiService())..add(FetchRecords()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registros de vendas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: BlocBuilder<RecordsBloc, RecordsState>(
          builder: (context, state) {
            if (state is RecordsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RecordsLoaded) {
              return ListView.builder(
                itemCount: state.records.length,
                itemBuilder: (context, index) {
                  final record = state.records[index];

                  // Convertendo os valores para String, se necessário
                  String dtMov = record['DT_MOV']?.toString() ?? 'N/A';
                  String valorTotalProdutos = record['VALOR_TOTAL_PRODUTOS']?.toString() ?? '0.00';
                  String dscCortesia = record['DSC_CORTESIA']?.toString() ?? 'No Description';
                  String valorTotalNF = record['VALOR_TOTAL_NF']?.toString() ?? '0.00';

                  return ListTile(
                    title: Text(
                      'Data: $dtMov',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Produtos: $valorTotalProdutos', style: TextStyle(color: Colors.grey[700])),
                        Text('Descrição: $dscCortesia', style: TextStyle(color: Colors.grey[700])),
                        Text('Total NF: $valorTotalNF', style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                    onTap: () {
                      // Aqui você pode adicionar um feedback visual ao tocar na lista
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Você tocou no registro de $dtMov')),
                      );
                    },
                  );
                },
              );
            } else if (state is RecordsError) {
              return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
            }
            return Center(child: Text('Nenhum registro encontrado.'));
          },
        ),
      ),
    );
  }
}
