import 'dart:convert';

import 'package:collection/collection.dart';

class TuningOption {
	int? tuningOptionId;
	String? tuningOptionKey;
	String? label;
	String? content;
	int? laravelThroughKey;

	TuningOption({
		this.tuningOptionId, 
		this.tuningOptionKey, 
		this.label, 
		this.content, 
		this.laravelThroughKey, 
	});

	@override
	String toString() {
		return 'TuningOption(tuningOptionId: $tuningOptionId, tuningOptionKey: $tuningOptionKey, label: $label, content: $content, laravelThroughKey: $laravelThroughKey)';
	}

	factory TuningOption.fromMap(Map<String, dynamic> data) => TuningOption(
				tuningOptionId: data['tuning_option_id'] as int?,
				tuningOptionKey: data['tuning_option_key'] as String?,
				label: data['label'] as String?,
				content: data['content'] as String?,
				laravelThroughKey: data['laravel_through_key'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'tuning_option_id': tuningOptionId,
				'tuning_option_key': tuningOptionKey,
				'label': label,
				'content': content,
				'laravel_through_key': laravelThroughKey,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TuningOption].
	factory TuningOption.fromJson(String data) {
		return TuningOption.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [TuningOption] to a JSON string.
	String toJson() => json.encode(toMap());

	TuningOption copyWith({
		int? tuningOptionId,
		String? tuningOptionKey,
		String? label,
		String? content,
		int? laravelThroughKey,
	}) {
		return TuningOption(
			tuningOptionId: tuningOptionId ?? this.tuningOptionId,
			tuningOptionKey: tuningOptionKey ?? this.tuningOptionKey,
			label: label ?? this.label,
			content: content ?? this.content,
			laravelThroughKey: laravelThroughKey ?? this.laravelThroughKey,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! TuningOption) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			tuningOptionId.hashCode ^
			tuningOptionKey.hashCode ^
			label.hashCode ^
			content.hashCode ^
			laravelThroughKey.hashCode;
}
