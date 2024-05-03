

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/services/ChatService.dart';
import 'package:lead_gen/view/Chats/ChatBubble.dart';

class ChatPage extends StatefulWidget {
  final String receiveUserEmail;
  final String receivedUserId;
  const ChatPage(
      {super.key,
      required this.receiveUserEmail,
      required this.receivedUserId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  final ChatService _chatService = new ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Create a ScrollController
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add a listener to scroll to the bottom when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // Send the message using the ChatService
      await _chatService.sendMessage(
          widget.receivedUserId, _messageController.text);

      // Clear the text in the message input field
      _messageController.clear();

  
    }
  }

  @override
  void dispose() {
    // Dispose the ScrollController
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Scroll to the last message
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveUserEmail),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receivedUserId, firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        // Scroll to the last message after new messages are received
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
            .map((document) => _buildMessageItem(document))
            .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Align the messages to the right if the sender is the current user, otherwise to the left
    var alignment = (data['senderId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

     return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0), // Adjust the vertical padding as desired
        child: Container(
            alignment: alignment,
            child: Column(
                crossAxisAlignment: (data['senderId'] == firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                    // Display the sender's email
               
                    // Add horizontal padding to the chat bubble
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ChatBubble(message: data['message']),
                    ),
                ],
            ),
        ),
    );
  }

  // Build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: "Type your message",
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
            ),
            iconSize: 40,
          ),
        ],
      ),
    );
  }
}
