import 'package:flutter/material.dart';
import 'package:flutter_app/services/mensajes_services.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_app/widgets/header.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatStudentScreen extends StatefulWidget {
  const ChatStudentScreen({super.key});

  @override
  State<ChatStudentScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatStudentScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  Map<String, dynamic> user = {};

  List<String> options = [
    "1. Primer enunciado",
    "2. Primer enunciado",
    "3. Comunicarme con el RR/HH"
  ];
  late IO.Socket socket1;

  bool isLoading = true;

  String event = 'student-message';
  String chatId = '5';
  String to = '9';

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
        messages.addAll(fetchedMensajes);
      });
    } catch (e) {
      print('Error al obtener mensajes: $e');
    }
  }

  void _getUser() async {
    try {
      Map<String, dynamic> fetcheduser = await UserServices.getUser();
      setState(() {
        user = fetcheduser;
        isLoading = false;
      });
      _initializeSocket();
      print(user);
    } catch (e) {
      print('Error al obtener usuario: $e');
    }
  }

  void _initializeSocket() {
    print(
        '${dotenv.env['API_DOMAIN']}?from=${user['sub']}&to=$to&chat_id=$chatId&job_id=1');
    socket1 = IO.io(
      '${dotenv.env['API_DOMAIN']}?from=${user['sub']}&to=$to&chat_id=$chatId&job_id=1',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );
    socket1.connect();
    socket1.onConnect((_) {
      print('connect');
    });
    socket1.on(event, (data) {
      final receivedMessage = {
        'mensaje': data,
        'fecha': DateTime.now().toIso8601String(),
        'is_me': false,
      };
      setState(() {
        messages.add(receivedMessage);
      });
    });
    socket1.onDisconnect((_) => print('disconnect'));
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
    socket1.emit(event, newMessage);
    setState(() {
      messages.add(newMessage);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            color: colors.surface,
            child: const Header(),
          ),
        ),
        body: Column(
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
                    ),
                  ),
                ),
                itemBuilder: (context, element) {
                  return Align(
                    alignment: element['is_me']
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        color: element['is_me']
                            ? Colors.blue[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        element['mensaje'] == ''
                            ? 'No entendí tu pregunta. ¿Puedes ser más específico?'
                            : element['mensaje'] as String,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ));
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue[900],
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
          ),
          const SizedBox(width: 10),
          const Text(
            "Pablo Paredes",
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
