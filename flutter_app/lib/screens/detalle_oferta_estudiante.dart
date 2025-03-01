import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/footer_estudiante.dart';
import 'package:flutter_app/widgets/header.dart';

class DetalleOfertaEstudianteScreen extends StatefulWidget {
  final Map<String, dynamic>? oferta;
  const DetalleOfertaEstudianteScreen({super.key, this.oferta});

  @override
  State<DetalleOfertaEstudianteScreen> createState() => _DetalleOfertaEstudianteScreenState();
}

class _DetalleOfertaEstudianteScreenState extends State<DetalleOfertaEstudianteScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


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
  Widget build(BuildContext context){
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150.0), 
          child: Column(
            children: [
              const Header(),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Detalles del puesto'),
                  Tab(text: 'Sobre la empresa')
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
            _buildDetallesPuestoTab(),
            _buildSobreEmpresaTab(),
          ],
        ),
        bottomNavigationBar: const Footer(),
      );
  }

  Widget _buildDetallesPuestoTab(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Descripción del puesto",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3984)
              ),
            ),
          const SizedBox(height: 8),
          Text(
            widget.oferta!["descripcion"].toString(),
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            "Conocimientos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3984)
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.oferta!['oferta_requerimientos'].toString().split(',').map((item) => _buildBulletPoint(item.trim())).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              "Requisitos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3984),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.oferta!["oferta_funciones"].toString(),
              style: TextStyle(fontSize: 16),
            ),

        ]
      )  
    );
  }

  Widget _buildSobreEmpresaTab(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Acerca de nosotros",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3984),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.oferta!["empresa_descripcion"].toString(),
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Image.asset(
                'assets/map_icon.png', // Ruta del icono en assets
                width: 24, // Tamaño similar al de un icono
                height: 24,// Opcional, si la imagen es monocromática y quieres cambiar el color
              ),
              const SizedBox(width: 8),
                Text(
                widget.oferta!["empresa_locacion"].toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

}