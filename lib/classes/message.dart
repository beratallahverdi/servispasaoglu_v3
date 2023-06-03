import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:servispasaoglu_v3/api/messages.dart';

import 'message_status.dart';
import 'message_status_change.dart';
import 'user.dart';

class Message {
  int? messageId;
  int? orderId;
  int? userId;
  String? text;
  String? mimeType;
  String? file;
  String? createdAt;
  MessageStatus? messageStatus;
  String? messageStatusUpdateTime;
  String? deliverTime;
  Message? repliedMessage;
  User? user;
  List<MessageStatusChange>? messageStatusChange;

  Message({
    this.messageId,
    this.orderId,
    this.userId,
    this.text,
    this.mimeType,
    this.file,
    this.createdAt,
    this.messageStatus,
    this.messageStatusUpdateTime,
    this.deliverTime,
    this.repliedMessage,
    this.user,
    this.messageStatusChange,
  });

  @override
  String toString() {
    return 'Message(messageId: $messageId, orderId: $orderId, userId: $userId, text: $text, mimeType: $mimeType, file: $file, createdAt: $createdAt, messageStatus: $messageStatus, messageStatusUpdateTime: $messageStatusUpdateTime, deliverTime: $deliverTime, repliedMessage: $repliedMessage, user: $user, messageStatusChange: $messageStatusChange)';
  }

  factory Message.fromMap(Map<String, dynamic> data) => Message(
        messageId: data['message_id'] as int?,
        orderId: data['order_id'] as int?,
        userId: data['user_id'] as int?,
        text: data['text'] as String?,
        mimeType: data['mime_type'] as String?,
        file: data['file'] as dynamic,
        createdAt: data['createdAt'] as String?,
        messageStatus: data['message_status'] == null
            ? null
            : MessageStatus.fromMap(
                data['message_status'] as Map<String, dynamic>),
        messageStatusUpdateTime: data['message_status_update_time'] as String?,
        deliverTime: data['deliver_time'] as String?,
        repliedMessage: data['replied_message'] == null
            ? null
            : Message.fromMap(data['replied_message'] as Map<String, dynamic>),
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        messageStatusChange: (data['message_status_change'] as List<dynamic>?)
            ?.map((e) => MessageStatusChange.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'message_id': messageId,
        'order_id': orderId,
        'user_id': userId,
        'text': text,
        'mime_type': mimeType,
        'file': file,
        'createdAt': createdAt,
        'message_status': messageStatus?.toMap(),
        'message_status_update_time': messageStatusUpdateTime,
        'deliver_time': deliverTime,
        'replied_message': repliedMessage,
        'user': user?.toMap(),
        'message_status_change':
            messageStatusChange?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Message].
  factory Message.fromJson(String data) {
    return Message.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Message] to a JSON string.
  String toJson() => json.encode(toMap());

  Message copyWith({
    int? messageId,
    int? orderId,
    int? userId,
    String? text,
    String? mimeType,
    dynamic file,
    String? createdAt,
    MessageStatus? messageStatus,
    String? messageStatusUpdateTime,
    String? deliverTime,
    dynamic repliedMessage,
    User? user,
    List<MessageStatusChange>? messageStatusChange,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      mimeType: mimeType ?? this.mimeType,
      file: file ?? this.file,
      createdAt: createdAt ?? this.createdAt,
      messageStatus: messageStatus ?? this.messageStatus,
      messageStatusUpdateTime:
          messageStatusUpdateTime ?? this.messageStatusUpdateTime,
      deliverTime: deliverTime ?? this.deliverTime,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      user: user ?? this.user,
      messageStatusChange: messageStatusChange ?? this.messageStatusChange,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Message) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      messageId.hashCode ^
      orderId.hashCode ^
      userId.hashCode ^
      text.hashCode ^
      mimeType.hashCode ^
      file.hashCode ^
      createdAt.hashCode ^
      messageStatus.hashCode ^
      messageStatusUpdateTime.hashCode ^
      deliverTime.hashCode ^
      repliedMessage.hashCode ^
      user.hashCode ^
      messageStatusChange.hashCode;

  Future<File> download() async {
    if (file != null || file!.isNotEmpty) {
      return await MessagesAPI.download(this);
    }
    throw Exception('File is null');
  }
}
