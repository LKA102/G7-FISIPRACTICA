import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer_reclutador.dart';

class ChatReclutadorScreen extends StatefulWidget {
  const ChatReclutadorScreen({super.key});

  @override
  State<ChatReclutadorScreen> createState() => _ChatReclutadorScreenState();
}

class _ChatReclutadorScreenState extends State<ChatReclutadorScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> messages = [
    "Hola, estoy interesada en la vacante que publicaste."
  ];

  void _sendMessage(String message) {
    setState(() {
      messages.add(message);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: const Header(), // Usa el header si lo tienes
      ),
      body: Column(
        children: [
          _buildChatHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isReceived = index == 0;
                return Align(
                  alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      color: isReceived ? Colors.blue[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
      bottomNavigationBar: const Footer(), // Asegúrate de que este sea el Footer correcto
    );
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
            "María Soto Flores",
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

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Escribe un mensaje...",
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
