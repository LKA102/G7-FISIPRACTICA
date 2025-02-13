import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer_reclutador.dart';
import 'agregar_vacante_reclutador_screen.dart';

class OfertasReclutadorScreen extends StatelessWidget {
  const OfertasReclutadorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> vacantes = [
      {
        "titulo": "Practicante de TI",
        "empresa": "Adecco",
        "descripcion": "Líder en el sector bancario busca talentos...",
        "ubicacion": "San Isidro, Lima, Perú",
        "disponibilidad": "Inmediata",
        "postulantes": 20
      },
      {
        "titulo": "Practicante Business",
        "empresa": "Adecco",
        "descripcion": "Líder en el sector bancario busca talentos...",
        "ubicacion": "La Molina, Lima, Perú",
        "disponibilidad": "Inmediata",
        "postulantes": 30
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Header(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: vacantes.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                            vacantes[index]["empresa"]![0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vacantes[index]["titulo"]!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(vacantes[index]["empresa"]!),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(vacantes[index]["descripcion"]!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        const SizedBox(width: 5),
                        Text(vacantes[index]["ubicacion"]!),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.info, color: Colors.blue),
                        const SizedBox(width: 5),
                        Text("Disponibilidad: ${vacantes[index]["disponibilidad"]}",
                            style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                        ),
                        onPressed: () {},
                        child: Text("${vacantes[index]["postulantes"]}"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgregarVacanteReclutadorScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
