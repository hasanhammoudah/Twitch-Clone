import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch/providers/user_provider.dart';
import 'package:twitch/resources/firestore_methods.dart';
import 'package:twitch/widgets/custom_textfield.dart';
import 'package:twitch/widgets/loading_indicator.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.channelId});
  final String channelId;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _chatController = TextEditingController();
  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width:size.width > 600 ? size.width * 0.25: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('livestream')
                  .doc(widget.channelId)
                  .collection('comments')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data.docs[index]['username'],
                        style: TextStyle(
                          color: snapshot.data.docs[index]['uid'] ==
                                  userProvider.user.uid
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data.docs[index]['message'],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          CustomTextField(
            controller: _chatController,
            onSubmitted: (value) {
              FireStoreMethods()
                  .chat(_chatController.text, widget.channelId, context);
              setState(() {
                _chatController.text = "";
              });
            },
          ),
        ],
      ),
    );
  }
}
