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
  int _currentPage = 1;
  final int _totalPages = 5;

  @override
  Widget build(BuildContext context) {
    return /* Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: const Header(),
      ),
      body:  */
        Column(
      children: [
        const SizedBox(height: 10),
        _buildFilter(),
        const SizedBox(height: 10),
        Expanded(child: _buildPostulacionesList()),
        _buildPaginationControls(),
      ],
    ) /* ,
      bottomNavigationBar: const Footer(),
    ) */
        ;
  }

  // Filtro
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

  // Lista de postulaciones
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
                Text(post["empresa"]),
                Text(post["estatus"],
                    style: const TextStyle(color: Colors.green)),
                Text(post["tiempo"]),
                Text("Candidatos: ${post["candidatos"]}"),
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

  // Paginación con flechas (igual a HomeEstudiante)
  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _currentPage > 1
              ? () {
                  setState(() {
                    _currentPage--;
                  });
                  print("Página $_currentPage");
                }
              : null,
        ),
        Text("Página $_currentPage de $_totalPages"),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: _currentPage < _totalPages
              ? () {
                  setState(() {
                    _currentPage++;
                  });
                  print("Página $_currentPage");
                }
              : null,
        ),
      ],
    );
  }
}
