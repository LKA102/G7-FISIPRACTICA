import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import 'package:flutter_app/screens/crear_reclutador_screen.dart';
import 'editar_perfil_reclutador_screen.dart';

class ReclutadoresScreen extends StatefulWidget {
  const ReclutadoresScreen({super.key});

  @override
  _ReclutadoresScreenState createState() => _ReclutadoresScreenState();
}

class _ReclutadoresScreenState extends State<ReclutadoresScreen> {
  final List<Map<String, String>> reclutadores = [
    {'nombre': 'Carlos Díaz Sánchez', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Banco de Crédito del Perú', 'experiencia': '5', 'fecha': 'junio, 2024 - actualidad'},
    {'nombre': 'Ana Rodríguez Martínez', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Interbank', 'experiencia': '2', 'fecha': 'julio, 2024 - actualidad'},
    {'nombre': 'Luis Gómez Herrera', 'foto': 'assets/profile_picture.jpg', 'empresa': 'BBVA', 'experiencia': '1', 'fecha': 'agosto, 2024 - actualidad'},
    {'nombre': 'María García López', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Scotiabank', 'experiencia': '4', 'fecha': 'septiembre, 2024 - actualidad'},
    {'nombre': 'José Martínez Ríos', 'foto': 'assets/profile_picture.jpg', 'empresa': 'MiBanco', 'experiencia': '3', 'fecha': 'octubre, 2024 - actualidad'},
    {'nombre': 'Carlos Pérez Vargas', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Alicorp', 'experiencia': '5', 'fecha': 'noviembre, 2024 - actualidad'},
    {'nombre': 'Andrea Sánchez Gómez', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Backus', 'experiencia': '2', 'fecha': 'diciembre, 2024 - actualidad'},
    {'nombre': 'Sofía Fernández López', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Cemex Perú', 'experiencia': '1', 'fecha': 'enero, 2025 - actualidad'},
    {'nombre': 'Jorge Ruiz Fernández', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Corporación Lindley', 'experiencia': '3', 'fecha': 'febrero, 2025 - actualidad'},
    {'nombre': 'Felipe Vega González', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Ferreyros', 'experiencia': '4', 'fecha': 'marzo, 2025 - actualidad'},
    {'nombre': 'Laura Romero Cáceres', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Cosapi', 'experiencia': '2', 'fecha': 'abril, 2025 - actualidad'},
    {'nombre': 'Antonio Díaz Martínez', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Southern Copper Corporation', 'experiencia': '3', 'fecha': 'mayo, 2025 - actualidad'},
    {'nombre': 'Vanessa Rodríguez Ortiz', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Graña y Montero', 'experiencia': '4', 'fecha': 'junio, 2025 - actualidad'},
    {'nombre': 'Carlos Díaz Ramírez', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Inca Kola', 'experiencia': '5', 'fecha': 'julio, 2025 - actualidad'},
    {'nombre': 'Cristina Soto Blanco', 'foto': 'assets/profile_picture.jpg', 'empresa': 'Tottus', 'experiencia': '1', 'fecha': 'agosto, 2025 - actualidad'},
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
          width: 300, 
          constraints: BoxConstraints(
            maxHeight: 400, 
          ),
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
                      Navigator.of(context).pop(); // Cierra el diálogo actual
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarReclutadorScreen(reclutador: reclutador),
                        ),
                      );
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

  void _showCreateReclutadorDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Crear Nuevo Reclutador'),
        content: Text('¿Deseas crear un nuevo reclutador?'),
        actions: <Widget>[
          TextButton(
            child: Text('Denegar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
          ),
          TextButton(
            child: Text('Confirmar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
              // Navega a la pantalla de edición de reclutador
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditReclutadorScreen(),  // Aquí debes poner tu clase de pantalla
                ),
              );
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Header(), // Header en la parte superior de la pantalla
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Reclutadores', // Título de la pantalla
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
              itemCount: currentReclutadores.length,
              itemBuilder: (context, index) {
                String empresa = currentReclutadores[index]['empresa']!;
                Color empresaColor;

                switch (empresa) {
                  case 'Banco de Crédito del Perú':
                    empresaColor = Colors.blue;
                    break;
                  case 'Interbank':
                    empresaColor = Colors.green;
                    break;
                  case 'BBVA':
                    empresaColor = Colors.blue;
                    break;
                  case 'Scotiabank':
                    empresaColor = Colors.red;
                    break;
                  case 'MiBanco':
                    empresaColor = Colors.yellow;
                    break;
                  case 'Alicorp':
                    empresaColor = Colors.red;
                    break;
                  case 'Backus':
                    empresaColor = Colors.orange;
                    break;
                  case 'Cemex Perú':
                    empresaColor = Colors.blue;
                    break;
                  case 'Corporación Lindley':
                    empresaColor = Colors.red;
                    break;
                  case 'Ferreyros':
                    empresaColor = Colors.green;
                    break;
                  case 'Cosapi':
                    empresaColor = Colors.yellow;
                    break;
                  case 'Southern Copper Corporation':
                    empresaColor = Colors.red;
                    break;
                  case 'Graña y Montero':
                    empresaColor = Colors.orange;
                    break;
                  case 'Inca Kola':
                    empresaColor = Colors.yellow;
                    break;
                  case 'Tottus':
                    empresaColor = Colors.green;
                    break;
                  default:
                    empresaColor = Colors.blue;
                }

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: InkWell(
                    onTap: () => _showReclutadorDialog(currentReclutadores[index]),
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(currentReclutadores[index]['foto']!),
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                currentReclutadores[index]['nombre']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF1E3984),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  color: empresaColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  empresa,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120), // Ajusta para subir el botón
        child: FloatingActionButton(
          onPressed: _showCreateReclutadorDialog,
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF1E3984),
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