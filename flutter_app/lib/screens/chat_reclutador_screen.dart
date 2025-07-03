import 'package:flutter/material.dart';
import 'package:flutter_app/services/mensajes_services.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final logger = Logger();

enum ConnectionStatus { connecting, connected, disconnected, error }

class ChatReclutadorScreen extends StatefulWidget {
  final String studentId;
  final String jobId;
  final String studentName;
  final String? studentAvatar;
  final String chatId;

  const ChatReclutadorScreen(
      {required this.studentId,
      required this.jobId,
      required this.studentName,
      required this.chatId,
      this.studentAvatar,
      super.key});

  @override
  State<ChatReclutadorScreen> createState() => _ChatReclutadorScreenState();
}

class _ChatReclutadorScreenState extends State<ChatReclutadorScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];
  Map<String, dynamic> user = {};

  bool isLoading = true;
  bool isSending = false;
  late IO.Socket socket;
  ConnectionStatus connectionStatus = ConnectionStatus.disconnected;

  String event = 'recruiter-message';
  String chatId = '';

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    try {
      // Obtener información del usuario actual
      final userData = await UserServices.getUser();
      if (!mounted) return;

      setState(() {
        user = userData;
        chatId = widget.chatId;
      });

      // Inicializar socket después de tener la información necesaria
      _initializeSocket();

      // Cargar mensajes históricos
      await _fetchMensajes();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      logger.e('Error al inicializar el chat: $e');
      if (!mounted) return;
      setState(() {
        connectionStatus = ConnectionStatus.error;
        isLoading = false;
      });
      _showErrorSnackBar('Error al cargar el chat');
    }
  }

  Future<void> _fetchMensajes() async {
    try {
      final fetchedMensajes =
          await MensajesServices.getMensajes(int.parse(chatId));
      if (!mounted) return;

      setState(() {
        messages = fetchedMensajes;
      });

      // Scroll al último mensaje
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      logger.e('Error al obtener mensajes: $e');
      _showErrorSnackBar('Error al cargar los mensajes');
    }
  }

  void _initializeSocket() {
    setState(() {
      connectionStatus = ConnectionStatus.connecting;
    });

    socket = IO.io(
      '${dotenv.env['API_DOMAIN']}',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'query': {
          'from': user['sub'],
          'to': widget.studentId,
          'chat_id': chatId,
          'job_id': widget.jobId,
        },
      },
    );

    // Manejadores de eventos del socket
    socket.onConnect((_) {
      if (!mounted) return;
      setState(() => connectionStatus = ConnectionStatus.connected);
    });

    socket.onDisconnect((_) {
      if (!mounted) return;
      setState(() => connectionStatus = ConnectionStatus.disconnected);
    });

    socket.onConnectError((error) {
      logger.e('Error de conexión: $error');
      if (!mounted) return;
      setState(() => connectionStatus = ConnectionStatus.error);
      _showErrorSnackBar('Error de conexión');
    });

    socket.on(event, (data) {
      if (!mounted) return;
      final receivedMessage = {
        'mensaje': data,
        'fecha': DateTime.now().toIso8601String(),
        'is_me': false,
      };
      setState(() {
        messages.add(receivedMessage);
      });
      // Auto scroll al nuevo mensaje
      _scrollToBottom();
    });
  }

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() => isSending = true);

    try {
      final newMessage = {
        'from': user['sub'],
        'to': widget.studentId,
        'chat_id': chatId,
        'job_id': widget.jobId,
        'mensaje': message,
        'fecha': DateTime.now().toIso8601String(),
        'is_me': true,
      };

      socket.emit(event, newMessage);

      setState(() {
        messages.add(newMessage);
        _controller.clear();
        isSending = false;
      });

      _scrollToBottom();
    } catch (e) {
      logger.e('Error al enviar mensaje: $e');
      setState(() => isSending = false);
      _showErrorSnackBar('Error al enviar el mensaje');
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    if (socket.connected) {
      socket.disconnect();
    }
    socket.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        _buildChatHeader(),
        _buildConnectionStatus(),
        Expanded(
          child: GroupedListView<dynamic, String>(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
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
                      style: const TextStyle(color: Colors.white),
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
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    color:
                        element['is_me'] ? Colors.blue[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: element['is_me']
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        element['mensaje'] as String,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('HH:mm')
                            .format(DateTime.parse(element['fecha'])),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildConnectionStatus() {
    if (connectionStatus == ConnectionStatus.connected) {
      return const SizedBox.shrink();
    }

    Color backgroundColor;
    String message;

    switch (connectionStatus) {
      case ConnectionStatus.connecting:
        backgroundColor = Colors.orange;
        message = 'Conectando...';
        break;
      case ConnectionStatus.disconnected:
        backgroundColor = Colors.red;
        message = 'Desconectado - Intentando reconectar...';
        break;
      case ConnectionStatus.error:
        backgroundColor = Colors.red;
        message = 'Error de conexión';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: backgroundColor,
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue[900],
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: widget.studentAvatar != null
                ? NetworkImage(widget.studentAvatar!)
                : const AssetImage('assets/user_icon.png') as ImageProvider,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.studentName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  connectionStatus == ConnectionStatus.connected
                      ? 'En línea'
                      : 'Desconectado',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            connectionStatus == ConnectionStatus.connected
                ? Icons.circle
                : Icons.circle_outlined,
            color: connectionStatus == ConnectionStatus.connected
                ? Colors.green
                : Colors.grey,
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
              decoration: InputDecoration(
                hintText: "Escribe un mensaje...",
                border: const OutlineInputBorder(),
                enabled: connectionStatus == ConnectionStatus.connected,
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  _sendMessage(text);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          isSending
              ? const SizedBox(
                  width: 40,
                  height: 40,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: connectionStatus == ConnectionStatus.connected
                      ? () {
                          if (_controller.text.isNotEmpty) {
                            _sendMessage(_controller.text);
                          }
                        }
                      : null,
                ),
        ],
      ),
    );
  }
}
