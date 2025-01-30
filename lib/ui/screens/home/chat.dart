import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podlove_flutter/ui/widgets/custom_app_bar.dart';

class Chat extends StatefulWidget {
  final String userId;
  final String receiverId;
  final String name;

  const Chat(
      {super.key,
      required this.userId,
      required this.receiverId,
      required this.name});

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
        'participants': [widget.userId, widget.receiverId],
        'timestamp': FieldValue.serverTimestamp(),
      });

      messageController.clear();
    } catch (e) {
      print("❌ Error sending message: $e");
    }
  }

  Stream<QuerySnapshot> getMessages() {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('participants', arrayContains: widget.userId)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          appBar: CustomAppBar(title: widget.name),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: getMessages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return Center(child: Text("No messages yet"));
                    }

                    var messages = snapshot.data!.docs;

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 32.h),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var msg = messages[index];
                        bool isSentByMe = msg['senderId'] == widget.userId;

                        return ChatBubble(
                          message: msg['message'],
                          isSentByMe: isSentByMe,
                          time: "Now",
                        );
                      },
                    );
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
                ),
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.orangeAccent, size: 24.sp),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}

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
            margin: EdgeInsets.symmetric(vertical: 5.h),
            padding: EdgeInsets.all(12.w),
            constraints: BoxConstraints(
              maxWidth: 0.75.sw,
            ),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.orangeAccent : Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
                bottomLeft: isSentByMe ? Radius.circular(12.r) : Radius.zero,
                bottomRight: isSentByMe ? Radius.zero : Radius.circular(12.r),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 10.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
