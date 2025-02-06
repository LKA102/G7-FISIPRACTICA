import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class AdminEmpresaScreen extends StatefulWidget {
  const AdminEmpresaScreen({super.key});

  @override
  _AdminEmpresaScreenState createState() => _AdminEmpresaScreenState();
}

class _AdminEmpresaScreenState extends State<AdminEmpresaScreen> {
  final List<Map<String, String>> empresas = [
    {'nombre': 'Banco de Crédito del Perú', 'logo': ''},
    {'nombre': 'Interbank', 'logo': ''},
    {'nombre': 'BBVA', 'logo': ''},
    {'nombre': 'Scotiabank', 'logo': ''},
    {'nombre': 'MiBanco', 'logo': ''},
    {'nombre': 'Alicorp', 'logo': ''},
    {'nombre': 'Backus', 'logo': ''},
    {'nombre': 'Cemex Perú', 'logo': ''},
    {'nombre': 'Corporación Lindley', 'logo': ''},
    {'nombre': 'Ferreyros', 'logo': ''},
    {'nombre': 'Cosapi', 'logo': ''},
    {'nombre': 'Southern Copper Corporation', 'logo': ''},
    {'nombre': 'Graña y Montero', 'logo': ''},
    {'nombre': 'Inca Kola', 'logo': ''},
    {'nombre': 'Tottus', 'logo': ''},
  ];

  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
  }

  void _previousPage() {
    setState(() {
      if (_currentPage > 1) {
        _currentPage--;
      }
    });
  }

  void _nextPage() {
    setState(() {
      if (_currentPage * _itemsPerPage < empresas.length) {
        _currentPage++;
      }
    });
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  List<Widget> _buildPageNumbers(int totalPages) {
    List<Widget> pageNumbers = [];

    pageNumbers.add(_buildPageNumberButton(1));

    if (_currentPage > 3) {
      pageNumbers.add(Text('...'));
    }

    if (_currentPage > 1 && _currentPage < totalPages) {
      pageNumbers.add(_buildPageNumberButton(_currentPage));
    }

    if (_currentPage < totalPages - 2) {
      pageNumbers.add(Text('...'));
    }

    if (totalPages > 1) {
      pageNumbers.add(_buildPageNumberButton(totalPages));
    }

    return pageNumbers;
  }

  Widget _buildPageNumberButton(int page) {
    return TextButton(
      onPressed: () => _goToPage(page),
      child: Text(
        '$page',
        style: TextStyle(
          fontWeight: _currentPage == page ? FontWeight.bold : FontWeight.normal,
          color: _currentPage == page ? Color(0xFF1E3984) : Colors.black,
        ),
      ),
    );
  }

  // Función para mostrar un diálogo de confirmación con formato personalizado
  void _showConfirmationDialog(String empresa) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          title: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF005BAC),
                child: const Icon(Icons.business, color: Colors.white, size: 40), // Placeholder logo
              ),
              SizedBox(height: 10),
              Text(
                '¿Deseas ingresar a $empresa?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Aquí puedes agregar lógica para ingresar a la empresa
                  },
                ),
                SizedBox(width: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Denegar'),
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
    List<Map<String, String>> currentEmpresas = empresas.sublist(
      startIndex,
      endIndex > empresas.length ? empresas.length : endIndex,
    );

    int totalPages = (empresas.length / _itemsPerPage).ceil();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Header(), // Header en la parte superior de la pantalla
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Empresas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3984),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: currentEmpresas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      // Muestra el diálogo de confirmación al seleccionar una empresa
                      _showConfirmationDialog(currentEmpresas[index]['nombre']!);
                    },
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF005BAC),
                            child: const Icon(Icons.business, color: Colors.white, size: 30),
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
                );
              },
            ),
          ),
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
                  children: _buildPageNumbers(totalPages),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: _nextPage,
              ),
            ],
          ),
          Footer(), // Footer al final de la pantalla
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Alineación al final de la pantalla, sobre la última empresa
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 110.0, right: 15.0), // Ajuste para superponer en la esquina inferior derecha, más arriba
        child: FloatingActionButton(
          onPressed: () {
            // Acción al presionar el botón de agregar empresa
            print('Agregar nueva empresa');
          },
          backgroundColor: const Color(0xFF005BAC),
          child: const Icon(Icons.add),
          elevation: 10,
          tooltip: 'Agregar Empresa', // Descripción adicional
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