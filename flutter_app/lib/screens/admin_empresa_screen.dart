import 'package:flutter/material.dart';
import 'crear_empresa_screen.dart'; // Importamos la pantalla donde se creará la empresa
import '../widgets/header.dart';
import '../widgets/footer.dart';

class AdminEmpresaScreen extends StatefulWidget {
  const AdminEmpresaScreen({super.key});

  @override
  _AdminEmpresaScreenState createState() => _AdminEmpresaScreenState();
}

class _AdminEmpresaScreenState extends State<AdminEmpresaScreen> {
  final List<Map<String, String>> empresas = [
    {'nombre': 'Banco de Crédito del Perú', 'foto': 'assets/bcp.png'},
    {'nombre': 'Interbank', 'foto': 'assets/interbank.png'},
    {'nombre': 'BBVA', 'foto': 'assets/bbva.png'},
    {'nombre': 'Scotiabank', 'foto': 'assets/scotiabank.jpg'},
    {'nombre': 'MiBanco', 'foto': 'assets/mibanco.png'},
    {'nombre': 'Alicorp', 'foto': 'assets/alicorp.png'},
    {'nombre': 'Backus', 'foto': 'assets/backus.jpg'},
    {'nombre': 'Cemex Perú', 'foto': 'assets/cemex.png'},
    {'nombre': 'Corporación Lindley', 'foto': 'assets/lindley.png'},
    {'nombre': 'Ferreyros', 'foto': 'assets/ferreyros.png'},
    {'nombre': 'Cosapi', 'foto': 'assets/cosapi.jpg'},
    {'nombre': 'Southern Copper Corporation', 'foto': 'assets/southern.png'},
    {'nombre': 'Claro Perú', 'foto': 'assets/claro.png'},
    {'nombre': 'Inca Kola', 'foto': 'assets/inca.jpg'},
    {'nombre': 'Tottus', 'foto': 'assets/tottus.png'},
  ];

  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _itemsPerPage = 5;
  String _searchQuery = ""; // Variable de búsqueda

  void _previousPage() {
    setState(() {
      if (_currentPage > 1) {
        _currentPage--;
      }
    });
  }

  void _nextPage() {
    setState(() {
      if (_currentPage * _itemsPerPage < _filteredEmpresas.length) {
        _currentPage++;
      }
    });
  }

  List<Map<String, String>> get _filteredEmpresas {
    return empresas
        .where((empresa) =>
            empresa['nombre']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Función para mostrar el cuadro de confirmación de agregar empresa
  void _showAddConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          title: Column(
            children: const [
              Icon(
                Icons.add_circle,
                color: Colors.blue,
                size: 60,
              ),
              SizedBox(height: 20),
              Text(
                '¿Deseas crear una nueva empresa?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color.fromARGB(255, 8, 76, 131),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CrearEmpresaScreen()),
                    );
                  },
                ),
                const SizedBox(width: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Función para mostrar el cuadro de confirmación de eliminar empresa
  void _showDeleteConfirmationDialog(Map<String, String> empresa) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          title: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(empresa['foto']!),
              ),
              const SizedBox(height: 10),
              Text(
                '¿Deseas eliminar a ${empresa['nombre']}?',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Aquí puedes agregar la lógica para eliminar la empresa de la lista
                  },
                ),
                const SizedBox(width: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Denegar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    List<Map<String, String>> currentEmpresas = _filteredEmpresas.sublist(
      startIndex,
      endIndex > _filteredEmpresas.length ? _filteredEmpresas.length : endIndex,
    );

    int totalPages = (_filteredEmpresas.length / _itemsPerPage).ceil();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Header(),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Empresas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3984),
              ),
            ),
          ),
          
          // Buscador de empresas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              decoration: InputDecoration(
                labelText: 'Escriba la empresa',
                labelStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 155, 194, 204)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Lista de empresas
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: currentEmpresas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        _showDeleteConfirmationDialog(currentEmpresas[index]);
                      },
                      child: SizedBox(
                        height: 90,
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(currentEmpresas[index]['foto']!),
                            ),
                            title: Text(
                              currentEmpresas[index]['nombre']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF1E3984),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Paginación
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousPage,
              ),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: List.generate(
                    totalPages,
                    (index) => TextButton(
                      onPressed: () => setState(() => _currentPage = index + 1),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: _currentPage == (index + 1)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: _currentPage == (index + 1)
                              ? const Color(0xFF1E3984)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: _nextPage,
              ),
            ],
          ),
          Footer(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 110.0, right: 15.0),
        child: FloatingActionButton(
          onPressed: _showAddConfirmationDialog, // Mostrar cuadro de agregar empresa
          backgroundColor: const Color(0xFF005BAC),
          child: const Icon(Icons.add),
          elevation: 10,
          tooltip: 'Agregar Empresa',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}