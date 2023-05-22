part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatFetched extends ChatState {
  final Map<String, List<Message>> messages;

  const ChatFetched({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatError extends ChatState {
  final String message;

  const ChatError({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagesLoading extends ChatState {}

class MessagesFetched extends ChatState {
  final List<Message> messages;

  const MessagesFetched({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessagesError extends ChatState {
  final String message;

  const MessagesError({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSent extends ChatState {}
