import 'package:flutter/material.dart';
import 'package:luis_tuarez_flutter_asyncawait/services/mockapi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'async await luis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 15, 3, 244)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Asincronía'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MockApi mockApi = MockApi();
  Map<int, int> _counters = {};
  Map<int, bool> _loadings = {};

  Future<void> _incrementCounter(int buttonIndex) async {
    _startLoading(buttonIndex, () async {
      int newValue = await _fetchData(buttonIndex);
      setState(() {
        _counters[buttonIndex] = newValue;
      });
    });
  }

  Future<int> _fetchData(int buttonIndex) async {
    switch (buttonIndex) {
      case 1:
        return await mockApi.getFerrariInteger();
      case 2:
        return await mockApi.getHyundaiInteger();
      case 3:
        return await mockApi.getFisherPriceInteger();
      default:
        return 0;
    }
  }

  Future<void> _startLoading(int buttonIndex, Function() action) async {
    setState(() {
      _loadings[buttonIndex] = true;
    });

    await action();

    setState(() {
      _loadings[buttonIndex] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Ajusta según tus necesidades
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildCircularButton(
                    1, Icons.flash_on, 'Button 1', Colors.green),
                SizedBox(
                    height:
                        16.0), // Espacio entre el botón y el texto (ajusta según tus necesidades)
                Text(
                  '${_counters[1] ?? 0}',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 255, 10),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    height:
                        30.0), // Espacio entre el texto y el siguiente botón (ajusta según tus necesidades)
                _buildCircularButton(
                    2, Icons.directions_car, 'Button 2', Color.fromARGB(255, 255, 213, 0)),
                SizedBox(
                    height:
                        16.0), // Espacio entre el botón y el texto (ajusta según tus necesidades)
                Text(
                  '${_counters[2] ?? 0}',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 217, 0),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    height:
                        30.0), // Espacio entre el texto y el siguiente botón (ajusta según tus necesidades)
                _buildCircularButton(
                    3, Icons.directions_walk, 'Button 3', const Color.fromARGB(255, 249, 17, 0)),
                SizedBox(
                    height:
                        16.0), // Espacio entre el botón y el texto (ajusta según tus necesidades)
                Text(
                  '${_counters[3] ?? 0}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularButton(
      int buttonIndex, IconData icon, String label, Color color) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _loadings[buttonIndex] == true
              ? null
              : () => _incrementCounter(buttonIndex),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20.0),
            primary: color,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, color: Colors.black, size: 36),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 150, // Ajusta el ancho del contenedor según tus necesidades
          child: LinearProgressIndicator(
            value: _loadings[buttonIndex] == true ? null : 0,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
