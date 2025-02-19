import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer_estudiante.dart';

class MisPostulacionesScreen extends StatefulWidget {
  const MisPostulacionesScreen({super.key});

  @override
  State<MisPostulacionesScreen> createState() => _MisPostulacionesScreenState();
}

class _MisPostulacionesScreenState extends State<MisPostulacionesScreen> {
  String _selectedFilter = "En proceso";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Header(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildFilter(),
          const SizedBox(height: 10),
          Expanded(
              child:
                  _buildPostulacionesList()), // Uso de Expanded para evitar overflow
          _buildPagination(),
        ],
      ),
      bottomNavigationBar: const Footer(), // Se mantiene el footer
    );
  }

  // Implementación del filtro
  Widget _buildFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        value: _selectedFilter,
        items: ["En proceso", "CV visto", "Finalista"]
            .map((filter) => DropdownMenuItem(
                  value: filter,
                  child: Text(filter),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedFilter = value!;
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Filtrar por",
        ),
      ),
    );
  }

  // Implementación de la lista de postulaciones
  Widget _buildPostulacionesList() {
    List<Map<String, dynamic>> postulaciones = [
      {
        "titulo": "Practicante Frontend",
        "empresa": "Interbank",
        "estatus": "En proceso",
        "tiempo": "Hace 2 semanas",
        "candidatos": 120,
      },
      {
        "titulo": "Practicante Backend",
        "empresa": "BBVA",
        "estatus": "CV visto",
        "tiempo": "Hace 3 días",
        "candidatos": 89,
      },
      {
        "titulo": "Data Analyst Intern",
        "empresa": "BCP",
        "estatus": "Finalista",
        "tiempo": "Hace 1 semana",
        "candidatos": 50,
      }
    ];

    return ListView.builder(
      itemCount: postulaciones.length,
      itemBuilder: (context, index) {
        final post = postulaciones[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          elevation: 3,
          child: ListTile(
            leading: const Icon(Icons.work, color: Colors.blue),
            title: Text(post["titulo"],
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post["empresa"], style: const TextStyle(fontSize: 14)),
                Text(post["estatus"],
                    style: const TextStyle(color: Colors.green, fontSize: 14)),
                Text(post["tiempo"], style: const TextStyle(fontSize: 12)),
                Text("Candidatos: ${post["candidatos"]}",
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              print("Ver detalles de ${post["titulo"]}");
            },
          ),
        );
      },
    );
  }

  // Implementación de la paginación
  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ElevatedButton(
              onPressed: () {
                print("Página ${index + 1}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
              ),
              child: Text("${index + 1}"),
            ),
          );
        }),
      ),
    );
  }
}
