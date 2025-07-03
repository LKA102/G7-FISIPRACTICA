import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat_estudiante_reclutador_screen.dart';
import 'package:flutter_app/services/mensajes_services.dart';
import 'package:flutter_app/services/user_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final logger = Logger();

enum ConnectionStatus { connecting, connected, disconnected, error }

enum MessageStatus { sending, sent, error }

class ChatScreen extends StatefulWidget {
  final String company;
  final String chatId;
  final String jobId;

  const ChatScreen({
    required this.company,
    required this.chatId,
    required this.jobId,
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _chatOptions = [
    {
      'id': '1',
      'text': '¿Cuál es el proceso de selección?',
      'response': '''El proceso de selección consta de las siguientes etapas:
1. Evaluación de CV
2. Pruebas psicotécnicas
3. Entrevista con RRHH
4. Entrevista técnica
5. Entrevista final''',
    },
    {
      'id': '2',
      'text': '¿Cuáles son los requisitos para postular?',
      'response': '''Los requisitos principales son:
- Ser estudiante universitario de últimos ciclos o egresado
- Promedio ponderado mínimo de 14
- Disponibilidad para realizar prácticas a tiempo completo
- Nivel intermedio de inglés''',
    },
    {
      'id': '3',
      'text': 'Comunicarme con un reclutador',
      'isAction': true,
    },
  ];

  List<Map<String, dynamic>> messages = [];
  Map<String, dynamic> user = {};
  bool isLoading = true;
  bool isSending = false;
  bool isTyping = false;
  late IO.Socket socket;
  ConnectionStatus connectionStatus = ConnectionStatus.disconnected;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    try {
      // Obtener información del usuario
      final userData = await UserServices.getUser();
      if (!mounted) return;

      setState(() {
        user = userData;
        messages = [
          {
            'mensaje': '''¡Hola! Soy el asistente virtual de FISIPRACTICA 👋

Estoy aquí para ayudarte con información sobre el proceso de selección en ${widget.company}. 

¿En qué puedo ayudarte hoy?''',
            'fecha': DateTime.now().toIso8601String(),
            'is_me': false,
            'showOptions': true,
          }
        ];
      });

      // Inicializar socket y cargar mensajes
      _initializeSocket();
      await _fetchMensajes();

      setState(() => isLoading = false);
    } catch (e) {
      logger.e('Error al inicializar el chat: $e');
      _showErrorSnackBar('Error al cargar el chat');
      setState(() => isLoading = false);
    }
  }

  Future<void> _fetchMensajes() async {
    try {
      final fetchedMensajes =
          await MensajesServices.getMensajes(int.parse(widget.chatId));
      if (!mounted) return;

      setState(() {
        messages.addAll(fetchedMensajes.where((msg) =>
            !messages.any((existingMsg) => existingMsg['id'] == msg['id'])));
      });

      _scrollToBottom();
    } catch (e) {
      logger.e('Error al obtener mensajes: $e');
      _showErrorSnackBar('Error al cargar los mensajes');
    }
  }

  void _initializeSocket() {
    setState(() => connectionStatus = ConnectionStatus.connecting);

    socket = IO.io(
      '${dotenv.env['API_DOMAIN']}',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'query': {
          'from': user['sub'],
          'chat_id': widget.chatId,
          'job_id': widget.jobId,
          'company': widget.company,
        },
      },
    );

    socket.onConnect((_) {
      if (!mounted) return;
      setState(() => connectionStatus = ConnectionStatus.connected);
    });

    socket.onDisconnect((_) {
      if (!mounted) return;
      setState(() {
        connectionStatus = ConnectionStatus.disconnected;
        isTyping = false;
      });
    });

    socket.on('typing', (_) {
      if (!mounted) return;
      setState(() => isTyping = true);
    });

    socket.on('stop_typing', (_) {
      if (!mounted) return;
      setState(() => isTyping = false);
    });

    socket.onConnectError((error) {
      logger.e('Error de conexión: $error');
      if (!mounted) return;
      setState(() => connectionStatus = ConnectionStatus.error);
      _showErrorSnackBar('Error de conexión');
    });

    socket.on('message', (data) {
      if (!mounted) return;
      setState(() {
        isTyping = false;
        messages.add({
          'mensaje': data,
          'fecha': DateTime.now().toIso8601String(),
          'is_me': false,
          'showOptions': true,
        });
      });
      _scrollToBottom();
    });
  }

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() => isSending = true);

    try {
      final newMessage = {
        'from': user['sub'],
        'chat_id': widget.chatId,
        'job_id': widget.jobId,
        'company': widget.company,
        'mensaje': message,
        'fecha': DateTime.now().toIso8601String(),
        'is_me': true,
      };

      final messageWithStatus = Map<String, dynamic>.from(newMessage)
        ..['status'] = MessageStatus.sending;

      setState(() {
        messages.add(messageWithStatus);
        _controller.clear();
        messageWithStatus['status'] = MessageStatus.sent;
        isTyping = true;
      });

      socket.emit('message', newMessage);
      _scrollToBottom();
    } catch (e) {
      logger.e('Error al enviar mensaje: $e');
      if (!mounted) return;
      setState(() {
        final lastMessage = messages.lastWhere((msg) => msg['is_me'] == true);
        lastMessage['status'] = MessageStatus.error;
        isSending = false;
        isTyping = false;
      });
      _showErrorSnackBar('Error al enviar el mensaje');
    } finally {
      if (mounted) setState(() => isSending = false);
    }
  }

  String _findBotResponse(String message) {
    // Convertir mensaje a minúsculas para mejor comparación
    message = message.toLowerCase();

    // Buscar coincidencias en las opciones predefinidas
    for (var option in _chatOptions) {
      if (message.contains(option['text'].toLowerCase()) &&
          !option['isAction']) {
        return option['response'];
      }
    }

    // Palabras clave específicas
    if (message.contains('requisito') || message.contains('postular')) {
      return _chatOptions[1]['response'];
    }
    if (message.contains('proceso') ||
        message.contains('selección') ||
        message.contains('etapa')) {
      return _chatOptions[0]['response'];
    }
    if (message.contains('reclutador') ||
        message.contains('humanos') ||
        message.contains('rrhh')) {
      return '''¿Deseas hablar con un reclutador? 
Puedes hacer clic en el botón "Comunicarme con un reclutador" que aparece debajo.''';
    }

    // Respuesta por defecto
    return '''Lo siento, no he podido entender tu pregunta. 
¿Podrías reformularla o seleccionar una de las opciones disponibles?''';
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

  void _goToChat() {
    if (socket.connected) {
      socket.disconnect();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatStudentScreen(),
      ),
    );
  }

  @override
  void dispose() {
    socket.off('message');
    socket.offAny();

    try {
      if (socket.connected) {
        socket.disconnect();
      }
      socket.dispose();
    } catch (e) {
      logger.e('Error al desconectar el socket: $e');
    }

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
              return Column(
                children: [
                  _buildMessage(element),
                  if (element['showOptions'] == true && !element['is_me'])
                    _buildOptions(),
                  if (isTyping && messages.last == element)
                    _buildTypingIndicator(),
                ],
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

  Widget _buildMessage(Map<String, dynamic> message) {
    return Align(
      alignment:
          message['is_me'] ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: message['is_me'] ? Colors.blue[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: message['is_me']
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message['mensaje'] as String,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('HH:mm').format(DateTime.parse(message['fecha'])),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (message['is_me']) ...[
                  const SizedBox(width: 4),
                  _buildMessageStatus(message['status']),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageStatus(MessageStatus? status) {
    switch (status) {
      case MessageStatus.sending:
        return const SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      case MessageStatus.sent:
        return const Icon(
          Icons.check,
          size: 16,
          color: Colors.green,
        );
      case MessageStatus.error:
        return const Icon(
          Icons.error_outline,
          size: 16,
          color: Colors.red,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue[900],
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                AssetImage('assets/${widget.company.toLowerCase()}.png'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.company,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Asistente Virtual',
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

  Widget _buildOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _chatOptions.map((option) {
          final bool isAction = option['isAction'] ?? false;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ElevatedButton(
              onPressed:
                  isAction ? _goToChat : () => _sendMessage(option['text']),
              style: ElevatedButton.styleFrom(
                backgroundColor: isAction ? Colors.blue[900] : Colors.white,
                foregroundColor: isAction ? Colors.white : Colors.black87,
                side: BorderSide(color: Colors.blue[900]!),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                option['text'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        }).toList(),
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
                hintText: "Escribe tu pregunta...",
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

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(1),
            _buildDot(2),
            _buildDot(3),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 * index),
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: Colors.green[300]?.withOpacity(value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
