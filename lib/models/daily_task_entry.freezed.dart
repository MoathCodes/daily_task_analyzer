// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_task_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyTaskEntry {

 int? get id; DateTime get date; String get text; int get wordCount; double get avgLettersPerWord; String get aiFeedback; List<String> get keyVocabulary; String get keyMetric; double get avgWordLength; int get clarityScore;
/// Create a copy of DailyTaskEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyTaskEntryCopyWith<DailyTaskEntry> get copyWith => _$DailyTaskEntryCopyWithImpl<DailyTaskEntry>(this as DailyTaskEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyTaskEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.text, text) || other.text == text)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.avgLettersPerWord, avgLettersPerWord) || other.avgLettersPerWord == avgLettersPerWord)&&(identical(other.aiFeedback, aiFeedback) || other.aiFeedback == aiFeedback)&&const DeepCollectionEquality().equals(other.keyVocabulary, keyVocabulary)&&(identical(other.keyMetric, keyMetric) || other.keyMetric == keyMetric)&&(identical(other.avgWordLength, avgWordLength) || other.avgWordLength == avgWordLength)&&(identical(other.clarityScore, clarityScore) || other.clarityScore == clarityScore));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,text,wordCount,avgLettersPerWord,aiFeedback,const DeepCollectionEquality().hash(keyVocabulary),keyMetric,avgWordLength,clarityScore);

@override
String toString() {
  return 'DailyTaskEntry(id: $id, date: $date, text: $text, wordCount: $wordCount, avgLettersPerWord: $avgLettersPerWord, aiFeedback: $aiFeedback, keyVocabulary: $keyVocabulary, keyMetric: $keyMetric, avgWordLength: $avgWordLength, clarityScore: $clarityScore)';
}


}

/// @nodoc
abstract mixin class $DailyTaskEntryCopyWith<$Res>  {
  factory $DailyTaskEntryCopyWith(DailyTaskEntry value, $Res Function(DailyTaskEntry) _then) = _$DailyTaskEntryCopyWithImpl;
@useResult
$Res call({
 int? id, DateTime date, String text, int wordCount, double avgLettersPerWord, String aiFeedback, List<String> keyVocabulary, String keyMetric, double avgWordLength, int clarityScore
});




}
/// @nodoc
class _$DailyTaskEntryCopyWithImpl<$Res>
    implements $DailyTaskEntryCopyWith<$Res> {
  _$DailyTaskEntryCopyWithImpl(this._self, this._then);

  final DailyTaskEntry _self;
  final $Res Function(DailyTaskEntry) _then;

/// Create a copy of DailyTaskEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? date = null,Object? text = null,Object? wordCount = null,Object? avgLettersPerWord = null,Object? aiFeedback = null,Object? keyVocabulary = null,Object? keyMetric = null,Object? avgWordLength = null,Object? clarityScore = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,avgLettersPerWord: null == avgLettersPerWord ? _self.avgLettersPerWord : avgLettersPerWord // ignore: cast_nullable_to_non_nullable
as double,aiFeedback: null == aiFeedback ? _self.aiFeedback : aiFeedback // ignore: cast_nullable_to_non_nullable
as String,keyVocabulary: null == keyVocabulary ? _self.keyVocabulary : keyVocabulary // ignore: cast_nullable_to_non_nullable
as List<String>,keyMetric: null == keyMetric ? _self.keyMetric : keyMetric // ignore: cast_nullable_to_non_nullable
as String,avgWordLength: null == avgWordLength ? _self.avgWordLength : avgWordLength // ignore: cast_nullable_to_non_nullable
as double,clarityScore: null == clarityScore ? _self.clarityScore : clarityScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyTaskEntry].
extension DailyTaskEntryPatterns on DailyTaskEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyTaskEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyTaskEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyTaskEntry value)  $default,){
final _that = this;
switch (_that) {
case _DailyTaskEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyTaskEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DailyTaskEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  DateTime date,  String text,  int wordCount,  double avgLettersPerWord,  String aiFeedback,  List<String> keyVocabulary,  String keyMetric,  double avgWordLength,  int clarityScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyTaskEntry() when $default != null:
return $default(_that.id,_that.date,_that.text,_that.wordCount,_that.avgLettersPerWord,_that.aiFeedback,_that.keyVocabulary,_that.keyMetric,_that.avgWordLength,_that.clarityScore);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  DateTime date,  String text,  int wordCount,  double avgLettersPerWord,  String aiFeedback,  List<String> keyVocabulary,  String keyMetric,  double avgWordLength,  int clarityScore)  $default,) {final _that = this;
switch (_that) {
case _DailyTaskEntry():
return $default(_that.id,_that.date,_that.text,_that.wordCount,_that.avgLettersPerWord,_that.aiFeedback,_that.keyVocabulary,_that.keyMetric,_that.avgWordLength,_that.clarityScore);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  DateTime date,  String text,  int wordCount,  double avgLettersPerWord,  String aiFeedback,  List<String> keyVocabulary,  String keyMetric,  double avgWordLength,  int clarityScore)?  $default,) {final _that = this;
switch (_that) {
case _DailyTaskEntry() when $default != null:
return $default(_that.id,_that.date,_that.text,_that.wordCount,_that.avgLettersPerWord,_that.aiFeedback,_that.keyVocabulary,_that.keyMetric,_that.avgWordLength,_that.clarityScore);case _:
  return null;

}
}

}

/// @nodoc


class _DailyTaskEntry implements DailyTaskEntry {
  const _DailyTaskEntry({required this.id, required this.date, required this.text, required this.wordCount, required this.avgLettersPerWord, required this.aiFeedback, required final  List<String> keyVocabulary, required this.keyMetric, required this.avgWordLength, required this.clarityScore}): _keyVocabulary = keyVocabulary;
  

@override final  int? id;
@override final  DateTime date;
@override final  String text;
@override final  int wordCount;
@override final  double avgLettersPerWord;
@override final  String aiFeedback;
 final  List<String> _keyVocabulary;
@override List<String> get keyVocabulary {
  if (_keyVocabulary is EqualUnmodifiableListView) return _keyVocabulary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keyVocabulary);
}

@override final  String keyMetric;
@override final  double avgWordLength;
@override final  int clarityScore;

/// Create a copy of DailyTaskEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyTaskEntryCopyWith<_DailyTaskEntry> get copyWith => __$DailyTaskEntryCopyWithImpl<_DailyTaskEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyTaskEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.text, text) || other.text == text)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.avgLettersPerWord, avgLettersPerWord) || other.avgLettersPerWord == avgLettersPerWord)&&(identical(other.aiFeedback, aiFeedback) || other.aiFeedback == aiFeedback)&&const DeepCollectionEquality().equals(other._keyVocabulary, _keyVocabulary)&&(identical(other.keyMetric, keyMetric) || other.keyMetric == keyMetric)&&(identical(other.avgWordLength, avgWordLength) || other.avgWordLength == avgWordLength)&&(identical(other.clarityScore, clarityScore) || other.clarityScore == clarityScore));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,text,wordCount,avgLettersPerWord,aiFeedback,const DeepCollectionEquality().hash(_keyVocabulary),keyMetric,avgWordLength,clarityScore);

@override
String toString() {
  return 'DailyTaskEntry(id: $id, date: $date, text: $text, wordCount: $wordCount, avgLettersPerWord: $avgLettersPerWord, aiFeedback: $aiFeedback, keyVocabulary: $keyVocabulary, keyMetric: $keyMetric, avgWordLength: $avgWordLength, clarityScore: $clarityScore)';
}


}

/// @nodoc
abstract mixin class _$DailyTaskEntryCopyWith<$Res> implements $DailyTaskEntryCopyWith<$Res> {
  factory _$DailyTaskEntryCopyWith(_DailyTaskEntry value, $Res Function(_DailyTaskEntry) _then) = __$DailyTaskEntryCopyWithImpl;
@override @useResult
$Res call({
 int? id, DateTime date, String text, int wordCount, double avgLettersPerWord, String aiFeedback, List<String> keyVocabulary, String keyMetric, double avgWordLength, int clarityScore
});




}
/// @nodoc
class __$DailyTaskEntryCopyWithImpl<$Res>
    implements _$DailyTaskEntryCopyWith<$Res> {
  __$DailyTaskEntryCopyWithImpl(this._self, this._then);

  final _DailyTaskEntry _self;
  final $Res Function(_DailyTaskEntry) _then;

/// Create a copy of DailyTaskEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? date = null,Object? text = null,Object? wordCount = null,Object? avgLettersPerWord = null,Object? aiFeedback = null,Object? keyVocabulary = null,Object? keyMetric = null,Object? avgWordLength = null,Object? clarityScore = null,}) {
  return _then(_DailyTaskEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,avgLettersPerWord: null == avgLettersPerWord ? _self.avgLettersPerWord : avgLettersPerWord // ignore: cast_nullable_to_non_nullable
as double,aiFeedback: null == aiFeedback ? _self.aiFeedback : aiFeedback // ignore: cast_nullable_to_non_nullable
as String,keyVocabulary: null == keyVocabulary ? _self._keyVocabulary : keyVocabulary // ignore: cast_nullable_to_non_nullable
as List<String>,keyMetric: null == keyMetric ? _self.keyMetric : keyMetric // ignore: cast_nullable_to_non_nullable
as String,avgWordLength: null == avgWordLength ? _self.avgWordLength : avgWordLength // ignore: cast_nullable_to_non_nullable
as double,clarityScore: null == clarityScore ? _self.clarityScore : clarityScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
