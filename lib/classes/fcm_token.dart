import 'dart:convert';

import 'package:collection/collection.dart';

class FcmToken {
	int? userId;
	String? fcmToken;

	FcmToken({this.userId, this.fcmToken});

	@override
	String toString() => 'FcmToken(userId: $userId, fcmToken: $fcmToken)';

	factory FcmToken.fromMap(Map<String, dynamic> data) => FcmToken(
				userId: data['user_id'] as int?,
				fcmToken: data['fcm_token'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'user_id': userId,
				'fcm_token': fcmToken,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FcmToken].
	factory FcmToken.fromJson(String data) {
		return FcmToken.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [FcmToken] to a JSON string.
	String toJson() => json.encode(toMap());

	FcmToken copyWith({
		int? userId,
		String? fcmToken,
	}) {
		return FcmToken(
			userId: userId ?? this.userId,
			fcmToken: fcmToken ?? this.fcmToken,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! FcmToken) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => userId.hashCode ^ fcmToken.hashCode;
}
