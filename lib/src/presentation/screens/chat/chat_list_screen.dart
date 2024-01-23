import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/bloc/chat/chat_bloc.dart';
import 'package:food_ninja/src/data/models/message.dart';
import 'package:food_ninja/src/data/models/user.dart';
import 'package:food_ninja/src/data/services/firestore_db.dart';
import 'package:food_ninja/src/presentation/widgets/image_placeholder.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  Map<String, List<Message>> messages = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(FetchChats());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatFetched) {
          messages = state.messages;
        }
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/svg/pattern-small.svg",
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chat",
                      style: CustomTextStyle.size25Weight600Text(),
                    ),

                    const SizedBox(height: 20),

                    // Chat list
                    BlocBuilder<ChatBloc, ChatState>(
                      builder: (context, state) {
                        if (state is ChatLoading) {
                          return ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: ChatShimmerItem(),
                              );
                            },
                          );
                        } else if (state is ChatError) {
                          return Center(
                            child: Text(state.message),
                          );
                        } else {
                          if (messages.isEmpty) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: const Center(
                                child: Text("No chats yet"),
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: messages.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String key = messages.keys.elementAt(index);
                              List<Message> messagesList = messages[key]!;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ChatItem(
                                  messagesList: messagesList,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatItem extends StatefulWidget {
  final List<Message> messagesList;
  const ChatItem({super.key, required this.messagesList});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  final FirestoreDatabase _db = FirestoreDatabase();
  late User otherUser;
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    var box = Hive.box('myBox');
    DocumentReference currentUserRef =
        FirebaseFirestore.instance.doc('/users/${box.get('id')}');

    // display their name and profile picture not the current user
    // id is the document id
    if (widget.messagesList[0].sender == currentUserRef) {
      var value =
          await _db.getDocumentFromReference(widget.messagesList[0].receiver);
      var map = value.data() as Map<String, dynamic>;
      otherUser = User.fromMap(map);
      otherUser.id = value.id;
    } else {
      var value =
          await _db.getDocumentFromReference(widget.messagesList[0].sender);
      var map = value.data() as Map<String, dynamic>;
      otherUser = User.fromMap(map);
      otherUser.id = value.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildChatItem();
        } else {
          return const ChatShimmerItem();
        }
      },
    );
  }

  Ink _buildChatItem() {
    return Ink(
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: AppStyles.largeBorderRadius,
        boxShadow: [AppStyles.boxShadow7],
      ),
      child: InkWell(
        borderRadius: AppStyles.largeBorderRadius,
        onTap: () {
          Navigator.pushNamed(
            context,
            '/chats/detail',
            arguments: otherUser,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 62,
                height: 62,
                child: ClipRRect(
                  borderRadius: AppStyles.defaultBorderRadius,
                  child: otherUser.image != null
                      ? Image.network(
                          otherUser.image!,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      otherUser.fullName,
                      style: CustomTextStyle.size16Weight400Text(),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.messagesList[0].text,
                      style: CustomTextStyle.size14Weight400Text(
                        AppColors().secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                DateFormat("hh:mm a").format(
                  widget.messagesList[0].createdAt,
                ),
                style: CustomTextStyle.size14Weight400Text(
                  AppColors().secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatShimmerItem extends StatelessWidget {
  const ChatShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors().cardColor,
          borderRadius: AppStyles.largeBorderRadius,
          boxShadow: [AppStyles.boxShadow7],
        ),
        child: InkWell(
          borderRadius: AppStyles.largeBorderRadius,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: AppColors.shimmerBaseColor,
                    borderRadius: AppStyles.defaultBorderRadius,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.shimmerBaseColor,
                          borderRadius: AppStyles.defaultBorderRadius,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 200,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.shimmerBaseColor,
                          borderRadius: AppStyles.defaultBorderRadius,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.shimmerBaseColor,
                    borderRadius: AppStyles.defaultBorderRadius,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
