import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class ReclutadoresScreen extends StatefulWidget {
  const ReclutadoresScreen({super.key});

  @override
  _ReclutadoresScreenState createState() => _ReclutadoresScreenState();
}

class _ReclutadoresScreenState extends State<ReclutadoresScreen> {
  final List<Map<String, String>> reclutadores = [
    {'nombre': 'Rosmeri Ccanto Flores', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Adecco', 'experiencia': '3', 'fecha': 'mayo, 2024 - actualidad'},
    {'nombre': 'Carlos Díaz Sánchez', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Interbank', 'experiencia': '5', 'fecha': 'junio, 2024 - actualidad'},
    {'nombre': 'Ana Rodríguez Martínez', 'foto': 'assets/profile_picture.jpg', 'empresa': 'BBVA', 'experiencia': '2', 'fecha': 'julio, 2024 - actualidad'},
    {'nombre': 'Luis Gómez Herrera', 'foto': 'assets/profile_picture.jpg', 'empresa': 'MiBanco', 'experiencia': '1', 'fecha': 'agosto, 2024 - actualidad'},
    {'nombre': 'María García López', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Scotiabank', 'experiencia': '4', 'fecha': 'septiembre, 2024 - actualidad'},
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
      if (_currentPage * _itemsPerPage < reclutadores.length) {
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

  // Función para mostrar el diálogo con los datos específicos del reclutador
  void _showReclutadorDialog(Map<String, String> reclutador) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 300, // Ajusta el ancho del diálogo
            height: 350, // Ajusta el alto del diálogo
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(reclutador['foto']!),
                ),
                SizedBox(height: 10),
                Text(
                  reclutador['nombre']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('- RR/HH de ${reclutador['empresa']}'),
                Text('- ${reclutador['experiencia']} años de experiencia'),
                Text('- ${reclutador['fecha']}'),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Editar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Agregar funcionalidad de edición si es necesario
                      },
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Eliminar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showConfirmationDialog(reclutador);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Función de confirmación de eliminación
  void _showConfirmationDialog(Map<String, String> reclutador) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Seguro de que deseas eliminar a ${reclutador['nombre']}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                Navigator.of(context).pop();
                // Lógica para eliminar al reclutador
              },
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
    List<Map<String, String>> currentReclutadores = reclutadores.sublist(
      startIndex,
      endIndex > reclutadores.length ? reclutadores.length : endIndex,
    );

    int totalPages = (reclutadores.length / _itemsPerPage).ceil();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Header(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: currentReclutadores.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: InkWell(
                    onTap: () => _showReclutadorDialog(currentReclutadores[index]),
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(currentReclutadores[index]['foto']!),
                          ),
                          title: Text(
                            currentReclutadores[index]['nombre']!,
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
          Footer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}