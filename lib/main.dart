import 'package:dio_calculadora_imc_flutter/model/IMC.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Vamos calcular o IMC'),
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
  final _imcList = <Imc>[];

  void _adicionarImc(String peso, String altura) {
    setState(() {
      Imc imc = Imc(double.parse(peso), double.parse(altura));
      _imcList.add(imc);
    });
  }

  @override
  Widget build(BuildContext context) {
    var pesoController = TextEditingController(text: "");
    var alturaController = MaskedTextController(text: "", mask: "0.00");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: pesoController,
              onChanged: (value) {
                debugPrint(value);
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  hintText: "Informe o peso",
                  prefixIcon: Icon(
                    Icons.balance,
                    color: Color.fromARGB(255, 16, 88, 38),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: alturaController,
              onChanged: (value) {
                debugPrint(value);
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  hintText: "Informe a altura",
                  prefixIcon: Icon(
                    Icons.height,
                    color: Color.fromARGB(255, 16, 88, 38),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    if (pesoController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Peso não preenchido!")));
                      return;
                    }

                    var peso = double.tryParse(pesoController.text);
                    if (peso == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Peso inválido!")));
                      return;
                    }

                    if (peso <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Peso menor ou igual à zero!")));
                      return;
                    }

                    if (alturaController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Altura não preenchida!")));
                      return;
                    }

                    var altura = double.tryParse(alturaController.text);
                    if (altura == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Altura inválida!")));
                      return;
                    }

                    if (altura <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Altura menor ou igual à zero!")));
                      return;
                    }

                    _adicionarImc(pesoController.text, alturaController.text);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 16, 88, 38))),
                  child: const Text(
                    "Calcular",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _imcList.length,
                    itemBuilder: (BuildContext bc, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        width: double.infinity,
                        child: Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "#0$index - IMC em ${DateFormat('dd/MM/yyyy - kk:mm').format(DateTime.now())}h",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Text(
                                              "Peso: ${_imcList[index].peso} kg"),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: const SizedBox(),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Text(
                                              "Altura: ${_imcList[index].altura} m"),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                    "IMC: ${_imcList[index].calcularIMC()} - Classificação: ${_imcList[index].classificacaoIMC()}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
