import 'dart:math';
import 'package:flutter/material.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  double investimentoMensal = 0.0;
  double taxaJurosMensal = 0.0;
  int numeroMeses = 0;

  double semJuros() {
    return investimentoMensal * numeroMeses;
  }

  double comJuros() {
    if (taxaJurosMensal == 0) return semJuros();

    return investimentoMensal *
        ((pow(1 + taxaJurosMensal, numeroMeses) - 1) / taxaJurosMensal);
  }

  void resultado() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Resultado"),
        content: Text(
          "Sem juros: R\$ ${semJuros().toStringAsFixed(2)}\n"
          "Com juros: R\$ ${comJuros().toStringAsFixed(2)}",
        ),
      ),
    );
  }

  InputDecoration campo(String texto) {
    return InputDecoration(
      hintText: texto,
      hintStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color.fromARGB(255, 19, 126, 62)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 178, 227, 182),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 138, 10),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Simulador de Investimentos!",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: campo("Investimento mensal"),
              onChanged: (value) {
                investimentoMensal = double.tryParse(value) ?? 0;
              },
            ),

            const SizedBox(height: 10),

            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: campo("Taxa de juros (%)"),
              onChanged: (value) {
                taxaJurosMensal = (double.tryParse(value) ?? 0) / 100;
              },
            ),

            const SizedBox(height: 10),

            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: campo("Quantidade de meses que deseja investir"),
              onChanged: (value) {
                numeroMeses = int.tryParse(value) ?? 0;
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: resultado,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 50, 118, 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Simular"),
            ),
          ],
        ),
      ),
    );
  }
}
