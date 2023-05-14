import 'package:flutter/material.dart';
import 'package:mspr/models/user.dart';
import 'package:mspr/models/message.dart';

class MessageItem extends StatefulWidget {
  final Message message;
  final User? user;

  const MessageItem({Key? key, required this.message, required this.user}) : super(key: key);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool isCheckClicked = false;
  bool isClearClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/user_thread');
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE1FDE1),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.user?.profilePicture ?? ''),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.user?.firstName} ${widget.user?.lastName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          if (!isCheckClicked && !isClearClicked)
                            IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.red,
                                size: 36,
                              ),
                              onPressed: () {
                                setState(() {
                                  isClearClicked = true;
                                  isCheckClicked = false;
                                });
                              },
                            ),
                          const SizedBox(width: 16),
                          if (!isClearClicked && !isCheckClicked)
                            IconButton(
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 36,
                              ),
                              onPressed: () {
                                setState(() {
                                  isClearClicked = false;
                                  isCheckClicked = true;
                                });
                              },
                            ),
                          if (isCheckClicked)
                            Row(
                              children: const [
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 36,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Accepté',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          if (isClearClicked)
                            Row(
                              children: const [
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 36,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Refusé',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Last message: ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height:10),
                  Text(
                    widget.message.content,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






