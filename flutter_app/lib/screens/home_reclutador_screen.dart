import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer_reclutador.dart';

class HomeReclutadorScreen extends StatefulWidget {
  const HomeReclutadorScreen({super.key});

  @override
  _HomeReclutadorScreenState createState() => _HomeReclutadorScreenState();
}

class _HomeReclutadorScreenState extends State<HomeReclutadorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> _vacantes = [
    {"titulo": "Practicante Analista Datos", "empresa": "Adecco", "descripcion": "Apoyo en análisis de datos empresariales.", "ubicacion": "San Isidro, Lima, Perú", "disponibilidad": "Inmediata"},
    {"titulo": "Practicante Backend", "empresa": "Adecco", "descripcion": "Desarrollo y mantenimiento de APIs.", "ubicacion": "La Molina, Lima, Perú", "disponibilidad": "Inmediata"},
  ];

  final List<Map<String, String>> _estudiantes = [
    {'nombre': 'Juan Pérez', 'foto': 'assets/profile_picture.jpg', 'descripcion': 'Descripción de Juan Pérez'},
    {'nombre': 'María López', 'foto': 'assets/profile_picture.jpg', 'descripcion': 'Descripción de María López'},
    {'nombre': 'Carlos García', 'foto': 'assets/profile_picture.jpg', 'descripcion': 'Descripción de Carlos García'},
    {'nombre': 'Ana Martínez', 'foto': 'assets/profile_picture.jpg', 'descripcion': 'Descripción de Ana Martínez'},
    {'nombre': 'Luis Rodríguez', 'foto': 'assets/profile_picture.jpg', 'descripcion': 'Descripción de Luis Rodríguez'},
  ];

  int _paginaActual = 1;
  final int _itemsPorPagina = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Column(
          children: [
            const Header(),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Mi Empresa"),
                Tab(text: "Estudiantes"),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.blue,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMiEmpresaTab(),
          _buildEstudiantesTab(),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildMiEmpresaTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Vacantes Disponibles", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _vacantes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(_vacantes[index]["titulo"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${_vacantes[index]["empresa"]} - ${_vacantes[index]["ubicacion"]}"),
                        Text(_vacantes[index]["descripcion"]!),
                        Text("Disponibilidad: ${_vacantes[index]["disponibilidad"]}", style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstudiantesTab() {
    int totalPaginas = (_estudiantes.length / _itemsPorPagina).ceil();
    List<Map<String, String>> estudiantesPagina = _estudiantes.skip((_paginaActual - 1) * _itemsPorPagina).take(_itemsPorPagina).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Estudiantes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: estudiantesPagina.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(estudiantesPagina[index]['foto']!),
                    ),
                    title: Text(estudiantesPagina[index]['nombre']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(estudiantesPagina[index]['descripcion']!),
                    onTap: () => _showStudentDialog(estudiantesPagina[index]),
                  ),
                );
              },
            ),
          ),
          _buildPaginationControls(totalPaginas),
        ],
      ),
    );
  }

  Widget _buildPaginationControls(int totalPaginas) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _paginaActual > 1 ? () { setState(() { _paginaActual--; }); } : null,
        ),
        Text("Página $_paginaActual de $totalPaginas"),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: _paginaActual < totalPaginas ? () { setState(() { _paginaActual++; }); } : null,
        ),
      ],
    );
  }

  void _showStudentDialog(Map<String, String> estudiante) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(estudiante['foto']!),
                radius: 50,
              ),
              const SizedBox(height: 10),
              Text(
                estudiante['nombre']!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(estudiante['descripcion']!),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ],
            ),
          ],
        );
      },
    );  
  }
}