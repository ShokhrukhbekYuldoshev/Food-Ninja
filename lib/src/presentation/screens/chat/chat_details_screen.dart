import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/bloc/chat/chat_bloc.dart';
import 'package:food_ninja/src/data/models/message.dart';
import 'package:food_ninja/src/data/models/user.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/back_button.dart';
import 'package:food_ninja/src/presentation/widgets/chat_bubble.dart';
import 'package:food_ninja/src/presentation/widgets/image_placeholder.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:hive/hive.dart';

class ChatDetailsScreen extends StatefulWidget {
  final User otherUser;
  const ChatDetailsScreen({
    super.key,
    required this.otherUser,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(
      FetchMessagesBetweenTwoUsers(
        otherUserId: widget.otherUser.id!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is MessagesFetched) {
          messages = state.messages;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(bounds),
                blendMode: BlendMode.dstIn,
                child: SvgPicture.asset(
                  "assets/svg/pattern-big.svg",
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomBackButton(),
                        const SizedBox(height: 20),
                        Text(
                          "Chat",
                          style: CustomTextStyle.size25Weight600Text(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.white.withOpacity(0.1),
                      borderRadius: AppStyles.largeBorderRadius,
                      boxShadow: [AppStyles.boxShadow7],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 62,
                          height: 62,
                          child: ClipRRect(
                            borderRadius: AppStyles.defaultBorderRadius,
                            child: widget.otherUser.image != null
                                ? Image.network(
                                    widget.otherUser.image!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return ImagePlaceholder(
                                        iconData: Icons.person,
                                        iconSize: 40,
                                      );
                                    },
                                  )
                                : ImagePlaceholder(
                                    iconData: Icons.person,
                                    iconSize: 40,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.otherUser.fullName,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyle.size16Weight400Text(),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.otherUser.email,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyle.size14Weight400Text(
                                AppColors().secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: BlocBuilder<ChatBloc, ChatState>(
                      builder: (context, state) {
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return ChatBubble(
                              message: message,
                              isMe: message.receiver.id == widget.otherUser.id,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    decoration: BoxDecoration(
                      color: AppColors().cardColor,
                      borderRadius: AppStyles.largeBorderRadius,
                      boxShadow: [
                        AppStyles.boxShadow7,
                      ],
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 25,
                        ),
                        filled: true,
                        fillColor: AppColors().cardColor,
                        hintText: 'Type a message',
                        hintStyle: TextStyle(
                          color: AppColors().secondaryTextColor,
                        ),
                        enabledBorder: AppStyles().defaultEnabledBorder,
                        focusedBorder: AppStyles.defaultFocusedBorder(),
                        suffixIcon: IntrinsicWidth(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (_messageController.text.isEmpty) return;
                                  var box = Hive.box('myBox');
                                  DocumentReference currentUserRef =
                                      FirebaseFirestore.instance
                                          .doc('/users/${box.get('id')}');
                                  DocumentReference otherUserRef =
                                      FirebaseFirestore.instance
                                          .doc('/users/${widget.otherUser.id}');
                                  Message message = Message(
                                    receiver: otherUserRef,
                                    sender: currentUserRef,
                                    text: _messageController.text,
                                    createdAt: DateTime.now(),
                                  );
                                  BlocProvider.of<ChatBloc>(context).add(
                                    SendMessage(
                                      message: message,
                                    ),
                                  );
                                  messages.insert(0, message);
                                  _messageController.clear();
                                },
                                icon: SvgPicture.asset(
                                  'assets/svg/send.svg',
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
