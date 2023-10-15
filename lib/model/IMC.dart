import 'dart:math';

class Imc {
  final double _peso;
  final double _altura;

  Imc(this._peso, this._altura);

  String get peso => _peso.toStringAsFixed(2);
  String get altura => _altura.toStringAsFixed(2);

  String calcularIMC() {
    return (_peso / pow(_altura, 2)).toStringAsFixed(2);
  }

  String classificacaoIMC() {
    double imc = double.parse(calcularIMC());

    if (imc < 16) return "Magreza grave";
    if (imc < 17) return "Magreza moderada";
    if (imc < 18.5) return "Magreza leve";
    if (imc < 25) return "Saudável";
    if (imc < 30) return "Sobrepeso";
    if (imc < 35) return "Obesidade Grau I";
    if (imc < 40) return "Obesidade Grau II (severa)";
    if (imc >= 40) return "Obesidade Grau III (mórbida)";
    return "";
  }
}
