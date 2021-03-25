import 'package:easyfarm/src/providers/farms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var farmsList = [
  {
    "name": "Fazenda Do Teste",
    "owner": "testemobile@easyfarm.io",
  },
  {
    "name": "Fazenda do Teste Mobile",
    "owner": "Caio",
  }
];

class FarmsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Farms>(builder: (ctx, farmsData, _) {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              title: Text(farmsData.farms.data[index].attributes.name),
              subtitle: Text(
                  'Essa fazenda pertence a ${farmsData.farms.data[index].attributes.owner} e é amplamente ultilizada no plantio de ${farmsData.farms.data[index].attributes.cultures[0].name}.'),
            ),
          );
        },
        itemCount: farmsData.farms.data.length,
      );
    });
  }
}
