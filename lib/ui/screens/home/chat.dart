import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class Chat extends StatefulWidget {
  final String userId;
  final String receiverId;
  final String name;
  const Chat({super.key, required this.userId, required this.receiverId, required this.name});


  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    String messageText = messageController.text.trim();
    if (messageText.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'senderId': widget.userId,
        'receiverId': widget.receiverId,
        'message': messageText,
        'participants': [
          widget.userId,
          widget.receiverId
        ], // ✅ Store as an array
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("✅ Message Sent: $messageText");
      messageController.clear();
    } catch (e) {
      print("❌ Error sending message: $e");
    }
  }


  Stream<QuerySnapshot> getMessages() {
    return FirebaseFirestore.instance
        .collection('messages')
        .where(Filter.or(
      Filter.and(Filter('senderId', isEqualTo: widget.userId), Filter('receiverId', isEqualTo: widget.receiverId)),
      Filter.and(Filter('senderId', isEqualTo: widget.receiverId), Filter('receiverId', isEqualTo: widget.userId)),
    ))
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    print("📲 Chat opened between: ${widget.userId} & ${widget.receiverId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "${widget.name}"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 20),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: getMessages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      print("❌ No messages found in Firestore.");
                      return Center(child: Text("No messages yet"));
                    }

                    var messages = snapshot.data!.docs;
                    print("🔥 Messages loaded: ${messages.length}");

                    return ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var msg = messages[index];
                        bool isSentByMe = msg['senderId'] == widget.userId;

                        return ChatBubble(
                          message: msg['message'],
                          isSentByMe: isSentByMe,
                          time: "Now", // Placeholder for timestamp
                        );
                      },
                    );
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Message Input Field & Send Button
  Widget _buildMessageInput() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.orangeAccent),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}

/// ✅ Chat Bubble UI
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final String time;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.orangeAccent : Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isSentByMe ? Radius.circular(12) : Radius.zero,
                bottomRight: isSentByMe ? Radius.zero : Radius.circular(12),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
