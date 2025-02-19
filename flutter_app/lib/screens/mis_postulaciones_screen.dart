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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            60.0), // Ajusta la altura del Header si es necesario
        child: Header(), // Agrega el header si lo usas en otras pantallas
      ),
      body: Center(
        child: Text("Mis Postulaciones"),
      ),
      bottomNavigationBar: Footer(), // Agregar el footer aquí
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

  // Implementación del Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1, // Segundo icono del footer (Mis Postulaciones)
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(
            icon: Icon(Icons.work), label: "Mis Postulaciones"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
      ],
    );
  }
}
