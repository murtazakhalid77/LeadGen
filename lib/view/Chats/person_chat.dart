import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];


  @override
void dispose() {
  _messageController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _topChat(),
                _bodyChat(),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
            _formChat(),
          ],
        ),
      ),
    );
  }

  _topChat() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Fiona',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: const Icon(
                  Icons.call,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: const Icon(
                  Icons.videocam,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyChat() {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        color: Colors.white,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          var chat = messages[index];
          return _itemChat(
            chat: chat['chat'],
            avatar: chat['avatar'],
            message: chat['message'],
            time: chat['time'],
          );
        },
      ),
    ),
  );
}

  // 0 = Send
  // 1 = Recieved
  _itemChat({int? chat, String? avatar, message, time}) {
  return Row(
    mainAxisAlignment: chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if (avatar != null) Avatar(image: avatar, size: 50),
      Flexible(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: chat == 0 ? Colors.indigo.shade100 : Colors.indigo.shade50,
            borderRadius: chat == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
          ),
          child: Text('$message'),
        ),
      ),
      if (chat == 1) Text('$time', style: TextStyle(color: Colors.grey.shade400)),
    ],
  );
}


 Widget _formChat() {
  return Positioned(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: const TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (message) {
                  // Remove the call to _sendMessage from here
                },
                controller: _messageController, // Add this line
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                _sendMessage(_messageController.text); // Call _sendMessage here
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blueAccent,
                ),
                padding: const EdgeInsets.all(14),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  void _sendMessage([String? message]) {
  print('Sending message: $message');
  if (message != null && message.isNotEmpty) {
    setState(() {
      messages.add({
        'chat': 0, // Assuming 0 is for sent messages
        'message': message,
        'time': '18.00',
      });
    });

    // Clear the text field
    _messageController.clear();
  }
}
}

class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  Avatar({this.image, this.size = 50, this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}