import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/src/data/models/message.dart';
import 'package:food_ninja/src/data/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository = ChatRepository();
  ChatBloc() : super(ChatInitial()) {
    on<FetchChats>((event, emit) async {
      emit(ChatLoading());
      try {
        Map<String, List<Message>> messages =
            await _chatRepository.fetchChats();
        emit(ChatFetched(messages: messages));
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(ChatError(message: e.toString()));
      }
    });
    on<FetchMessagesBetweenTwoUsers>((event, emit) async {
      emit(MessagesLoading());
      try {
        List<Message> messages =
            await _chatRepository.fetchMessagesBetweenTwoUsers(
          event.otherUserId,
        );
        emit(MessagesFetched(messages: messages));
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(MessagesError(message: e.toString()));
      }
    });
    on<SendMessage>((event, emit) async {
      emit(ChatInitial());
      try {
        await _chatRepository.sendMessage(
          event.message,
        );
        emit(MessageSent());
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(MessagesError(message: e.toString()));
      }
    });
  }
}
