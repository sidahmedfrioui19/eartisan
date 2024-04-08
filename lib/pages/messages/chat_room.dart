import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/messages/widgets/message_appbar.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatRoom extends StatefulWidget {
  final String user_id;
  final String firstname;
  final String lastname;
  final String pictureUrl;
  final bool available;

  const ChatRoom({
    Key? key,
    required this.user_id,
    required this.firstname,
    required this.lastname,
    required this.pictureUrl,
    required this.available,
  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  void connectSocket() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? jwtToken = await secureStorage.read(key: 'jwtToken');

    Socket socket = io(
        'https://job-adv-backend.onrender.com',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emitWithAck('msg', 'init', ack: (data) {
        print('ack $data');
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
      });
    });
    socket.onConnectError((error) {
      print('Connection error: $error');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        userName: '${widget.firstname} ${widget.lastname}',
        profilePicUrl: '${widget.pictureUrl}',
        userStatus: widget.available,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: [],
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Expanded(
                    child: RoundedTextField(
                      controller: TextEditingController(),
                      hintText: 'Message...',
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
