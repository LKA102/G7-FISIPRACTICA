import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer_estudiante.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> messages = [
    "¡Hola soy el asistente virtual de FISIPRACTICA! ¿Cómo puedo ayudarte hoy?"
  ];
  List<String> options = [
    "1. Primer enunciado",
    "2. Primer enunciado",
    "3. Comunicarme con el RR/HH"
  ];

  void _sendMessage(String message) {
    setState(() {
      messages.add(message);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return /* Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: const Header(), // Se mantiene el header general
      ),
      body:  */
        Column(
      children: [
        _buildChatHeader(), // Ahora está dentro del cuerpo
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(messages.first,
                      style: const TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 10),
              _buildOptions(),
            ],
          ),
        ),
        _buildMessageInput(),
      ],
    ) /* ,
      bottomNavigationBar: const Footer(),
    ) */
        ;
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue[900],
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          const SizedBox(width: 10),
          const Text(
            "Rosmeri Ccanto",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.circle,
            color: Colors.green,
            size: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: options.map((option) {
        bool isPrimary = option.contains("3.");
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ElevatedButton(
            onPressed: () => _sendMessage(option),
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary ? Colors.blue[900] : Colors.white,
              foregroundColor: isPrimary ? Colors.white : Colors.black,
              side: BorderSide(color: Colors.blue[900]!),
            ),
            child: Text(option),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enviar un mensaje...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                _sendMessage(_controller.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
