import 'package:easyfarm/src/providers/auth.dart';
import 'package:easyfarm/src/providers/farms.dart';
import 'package:easyfarm/src/screens/farms/widgets/farms_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmsScreen extends StatefulWidget {
  @override
  _FarmsScreenState createState() => _FarmsScreenState();
}

class _FarmsScreenState extends State<FarmsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    Provider.of<Farms>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Farms>(context).fetchAndSetFarms().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazendas'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(child: FarmsList()),
              ],
            ),
    );
  }
}
