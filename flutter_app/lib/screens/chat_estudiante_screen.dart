import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer_estudiante.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [
    {
      "text":
          "¡Hola! Soy el asistente virtual de FISIPRÁCTICA. ¿Cómo puedo ayudarte hoy?",
      "isBot": true,
      "time": "12:31pm"
    }
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"text": text, "isBot": false, "time": "Ahora"});
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: const Header(),
      ),
      body: Column(
        children: [
          _buildChatHeader(),
          Expanded(child: _buildChatMessages()),
          _buildChatInput(),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  // Encabezado del chat con nombre y estado
  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          const SizedBox(width: 10),
          const Text("Rosmeri Ccanto",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(width: 5),
          const Icon(Icons.circle, color: Colors.green, size: 12),
        ],
      ),
    );
  }

  // Cuerpo del chat con mensajes
  Widget _buildChatMessages() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return Align(
          alignment:
              message['isBot'] ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: message['isBot'] ? Colors.blue.shade100 : Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message['text'],
                  style: TextStyle(
                    color: message['isBot'] ? Colors.black : Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    message['time'],
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Caja de entrada de texto
  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Escribir mensaje...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () => _sendMessage(_messageController.text),
          ),
        ],
      ),
    );
  }
}
