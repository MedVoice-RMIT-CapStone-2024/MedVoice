class ChatModel {
  final String message;
  final bool isMe;
  final String id;
  final DateTime time;

  ChatModel(
      {required this.message,
      required this.isMe,
      required this.id,
      required this.time});
}
