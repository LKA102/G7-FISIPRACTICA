import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/mensajes_services.dart';
import 'package:flutter_app/services/reclutadores_services.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final logger = Logger();

class ChatReclutadorScreen extends StatefulWidget {
  /* final int userId; */
  const ChatReclutadorScreen(/* this.userId,  */ {super.key});

  @override
  State<ChatReclutadorScreen> createState() => _ChatReclutadorScreenState();
}

class _ChatReclutadorScreenState extends State<ChatReclutadorScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [
    /* 
    "Hola, estoy interesada en la vacante que publicaste." */
  ];
  Map<String, dynamic> user = {};

  bool isLoading = true;
  late IO.Socket socket;

  String event = 'recruiter-message';
  String chatId = '5';
  String to = '11';

  @override
  void initState() {
    super.initState();
    _getUser();
    _fetchMensajes();
  }

  void _fetchMensajes() async {
    try {
      List<Map<String, dynamic>> fetchedMensajes =
          await MensajesServices.getMensajes(int.parse(chatId));
      setState(() {
        messages =
            fetchedMensajes; /* 
            .map((mensaje) => mensaje['mensaje'] as String)
            .toList(); */
      });
    } catch (e) {
      print('Error al obtener mensajes: $e');
    }
  }

  void _getUser() async {
    try {
      Map<String, dynamic> fetcheduser = await UserServices.getUser();
      /* int recruiter =
          await ReclutadoresServices.getReclutadorById(fetcheduser['sub']); */
      setState(() {
        user = fetcheduser;
        isLoading = false;
      });
      _initializeSocket(/* recruiter */);
      print(user);
    } catch (e) {
      print('Error al obtener usuario: $e');
    }
  }

  void _initializeSocket(/* int recruiterId */) {
    socket = IO.io(
      '${dotenv.env['API_DOMAIN']}?from=${user['sub']}&to=Scotiabank&chat_id=$chatId&job_id=1',
      <String, dynamic>{
        'transports': ['websocket'],
      },
    );
    socket.on(event, (data) {
      final receivedMessage = {
        'mensaje': data,
        'fecha': DateTime.now().toIso8601String(),
        'is_me': false,
      };
      setState(() {
        messages.add(receivedMessage);
      });
    });
  }

  void _sendMessage(String message) {
    final newMessage = {
      'from': user['sub'],
      'to': to,
      'chat_id': chatId,
      'job_id': 1,
      'mensaje': message,
      'fecha': DateTime.now().toIso8601String(),
      'is_me': true,
    };
    socket.emit(event, newMessage);
    setState(() {
      messages.add(newMessage);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return /* Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60.0),
      //   child: const Header(), // Usa el header si lo tienes
      // ),
      body:  */
        Column(
      children: [
        _buildChatHeader(),
        Expanded(
          child: GroupedListView<dynamic, String>(
            padding: EdgeInsets.all(8),
            reverse: true,
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages,
            groupBy: (element) {
              DateTime date = DateTime.parse(element['fecha']);
              return "${date.year}/${date.month}/${date.day}";
            },
            groupHeaderBuilder: (element) => SizedBox(
              height: 50,
              child: Center(
                  child: Card(
                color: Colors.blue[900],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat('d MMM y')
                        .format(DateTime.parse(element['fecha'])),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
            ),
            /* 
            groupSeparatorBuilder: (String fecha) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                fecha,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ), */
            itemBuilder: (context, element) {
              return Align(
                alignment: element['is_me']
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: /* Card(
                      child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(element['mensaje']),
                  )) */
                    Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    color:
                        element['is_me'] ? Colors.blue[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    element['mensaje'] as String,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ),
          /* ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(16.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              bool isReceived = messages[index]['user_id'] == user['sub'];
              return Align(
                alignment:
                    isReceived ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    color: isReceived ? Colors.blue[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    messages[index]['mensaje'] as String,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ), */
        ),
        _buildMessageInput(),
      ],
    ); /* ,
      //bottomNavigationBar: const Footer(), // Asegúrate de que este sea el Footer correcto
    ); */
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
