part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class FetchChats extends ChatEvent {}

class FetchMessagesBetweenTwoUsers extends ChatEvent {
  final String otherUserId;

  const FetchMessagesBetweenTwoUsers({required this.otherUserId});

  @override
  List<Object> get props => [otherUserId];
}

class SendMessage extends ChatEvent {
  final Message message;

  const SendMessage({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
