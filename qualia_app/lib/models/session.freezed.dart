// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Session _$SessionFromJson(Map<String, dynamic> json) {
  return _Session.fromJson(json);
}

/// @nodoc
mixin _$Session {
  String get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get lastActiveAt => throw _privateConstructorUsedError; // Profiles
  PartnerProfile get partner => throw _privateConstructorUsedError;
  UserProfile get user => throw _privateConstructorUsedError; // World State
  WorldState get worldState =>
      throw _privateConstructorUsedError; // Model Preset
  ComfyUIModelPreset get modelPreset =>
      throw _privateConstructorUsedError; // Chat History
  List<ChatMessage> get messages =>
      throw _privateConstructorUsedError; // Generated Images
  List<GeneratedImage> get images =>
      throw _privateConstructorUsedError; // Session Settings
  bool get isNSFWEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      DateTime lastActiveAt,
      PartnerProfile partner,
      UserProfile user,
      WorldState worldState,
      ComfyUIModelPreset modelPreset,
      List<ChatMessage> messages,
      List<GeneratedImage> images,
      bool isNSFWEnabled});

  $PartnerProfileCopyWith<$Res> get partner;
  $UserProfileCopyWith<$Res> get user;
  $WorldStateCopyWith<$Res> get worldState;
  $ComfyUIModelPresetCopyWith<$Res> get modelPreset;
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? lastActiveAt = null,
    Object? partner = null,
    Object? user = null,
    Object? worldState = null,
    Object? modelPreset = null,
    Object? messages = null,
    Object? images = null,
    Object? isNSFWEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActiveAt: null == lastActiveAt
          ? _value.lastActiveAt
          : lastActiveAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      partner: null == partner
          ? _value.partner
          : partner // ignore: cast_nullable_to_non_nullable
              as PartnerProfile,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserProfile,
      worldState: null == worldState
          ? _value.worldState
          : worldState // ignore: cast_nullable_to_non_nullable
              as WorldState,
      modelPreset: null == modelPreset
          ? _value.modelPreset
          : modelPreset // ignore: cast_nullable_to_non_nullable
              as ComfyUIModelPreset,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<GeneratedImage>,
      isNSFWEnabled: null == isNSFWEnabled
          ? _value.isNSFWEnabled
          : isNSFWEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PartnerProfileCopyWith<$Res> get partner {
    return $PartnerProfileCopyWith<$Res>(_value.partner, (value) {
      return _then(_value.copyWith(partner: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get user {
    return $UserProfileCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WorldStateCopyWith<$Res> get worldState {
    return $WorldStateCopyWith<$Res>(_value.worldState, (value) {
      return _then(_value.copyWith(worldState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ComfyUIModelPresetCopyWith<$Res> get modelPreset {
    return $ComfyUIModelPresetCopyWith<$Res>(_value.modelPreset, (value) {
      return _then(_value.copyWith(modelPreset: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
          _$SessionImpl value, $Res Function(_$SessionImpl) then) =
      __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      DateTime lastActiveAt,
      PartnerProfile partner,
      UserProfile user,
      WorldState worldState,
      ComfyUIModelPreset modelPreset,
      List<ChatMessage> messages,
      List<GeneratedImage> images,
      bool isNSFWEnabled});

  @override
  $PartnerProfileCopyWith<$Res> get partner;
  @override
  $UserProfileCopyWith<$Res> get user;
  @override
  $WorldStateCopyWith<$Res> get worldState;
  @override
  $ComfyUIModelPresetCopyWith<$Res> get modelPreset;
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
      _$SessionImpl _value, $Res Function(_$SessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? lastActiveAt = null,
    Object? partner = null,
    Object? user = null,
    Object? worldState = null,
    Object? modelPreset = null,
    Object? messages = null,
    Object? images = null,
    Object? isNSFWEnabled = null,
  }) {
    return _then(_$SessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActiveAt: null == lastActiveAt
          ? _value.lastActiveAt
          : lastActiveAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      partner: null == partner
          ? _value.partner
          : partner // ignore: cast_nullable_to_non_nullable
              as PartnerProfile,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserProfile,
      worldState: null == worldState
          ? _value.worldState
          : worldState // ignore: cast_nullable_to_non_nullable
              as WorldState,
      modelPreset: null == modelPreset
          ? _value.modelPreset
          : modelPreset // ignore: cast_nullable_to_non_nullable
              as ComfyUIModelPreset,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<GeneratedImage>,
      isNSFWEnabled: null == isNSFWEnabled
          ? _value.isNSFWEnabled
          : isNSFWEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionImpl implements _Session {
  const _$SessionImpl(
      {required this.id,
      required this.createdAt,
      required this.lastActiveAt,
      required this.partner,
      required this.user,
      required this.worldState,
      required this.modelPreset,
      final List<ChatMessage> messages = const [],
      final List<GeneratedImage> images = const [],
      this.isNSFWEnabled = false})
      : _messages = messages,
        _images = images;

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastActiveAt;
// Profiles
  @override
  final PartnerProfile partner;
  @override
  final UserProfile user;
// World State
  @override
  final WorldState worldState;
// Model Preset
  @override
  final ComfyUIModelPreset modelPreset;
// Chat History
  final List<ChatMessage> _messages;
// Chat History
  @override
  @JsonKey()
  List<ChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

// Generated Images
  final List<GeneratedImage> _images;
// Generated Images
  @override
  @JsonKey()
  List<GeneratedImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

// Session Settings
  @override
  @JsonKey()
  final bool isNSFWEnabled;

  @override
  String toString() {
    return 'Session(id: $id, createdAt: $createdAt, lastActiveAt: $lastActiveAt, partner: $partner, user: $user, worldState: $worldState, modelPreset: $modelPreset, messages: $messages, images: $images, isNSFWEnabled: $isNSFWEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt) &&
            (identical(other.partner, partner) || other.partner == partner) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.worldState, worldState) ||
                other.worldState == worldState) &&
            (identical(other.modelPreset, modelPreset) ||
                other.modelPreset == modelPreset) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.isNSFWEnabled, isNSFWEnabled) ||
                other.isNSFWEnabled == isNSFWEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      lastActiveAt,
      partner,
      user,
      worldState,
      modelPreset,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(_images),
      isNSFWEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionImplToJson(
      this,
    );
  }
}

abstract class _Session implements Session {
  const factory _Session(
      {required final String id,
      required final DateTime createdAt,
      required final DateTime lastActiveAt,
      required final PartnerProfile partner,
      required final UserProfile user,
      required final WorldState worldState,
      required final ComfyUIModelPreset modelPreset,
      final List<ChatMessage> messages,
      final List<GeneratedImage> images,
      final bool isNSFWEnabled}) = _$SessionImpl;

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get lastActiveAt;
  @override // Profiles
  PartnerProfile get partner;
  @override
  UserProfile get user;
  @override // World State
  WorldState get worldState;
  @override // Model Preset
  ComfyUIModelPreset get modelPreset;
  @override // Chat History
  List<ChatMessage> get messages;
  @override // Generated Images
  List<GeneratedImage> get images;
  @override // Session Settings
  bool get isNSFWEnabled;
  @override
  @JsonKey(ignore: true)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError; // Content
  List<String>? get actions => throw _privateConstructorUsedError;
  List<String>? get dialogues => throw _privateConstructorUsedError;
  String? get innerThought => throw _privateConstructorUsedError;
  String? get narration =>
      throw _privateConstructorUsedError; // Associated Image
  String? get imageId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      MessageType type,
      List<String>? actions,
      List<String>? dialogues,
      String? innerThought,
      String? narration,
      String? imageId});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? type = null,
    Object? actions = freezed,
    Object? dialogues = freezed,
    Object? innerThought = freezed,
    Object? narration = freezed,
    Object? imageId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dialogues: freezed == dialogues
          ? _value.dialogues
          : dialogues // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      innerThought: freezed == innerThought
          ? _value.innerThought
          : innerThought // ignore: cast_nullable_to_non_nullable
              as String?,
      narration: freezed == narration
          ? _value.narration
          : narration // ignore: cast_nullable_to_non_nullable
              as String?,
      imageId: freezed == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
          _$ChatMessageImpl value, $Res Function(_$ChatMessageImpl) then) =
      __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      MessageType type,
      List<String>? actions,
      List<String>? dialogues,
      String? innerThought,
      String? narration,
      String? imageId});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
      _$ChatMessageImpl _value, $Res Function(_$ChatMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? type = null,
    Object? actions = freezed,
    Object? dialogues = freezed,
    Object? innerThought = freezed,
    Object? narration = freezed,
    Object? imageId = freezed,
  }) {
    return _then(_$ChatMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      actions: freezed == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dialogues: freezed == dialogues
          ? _value._dialogues
          : dialogues // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      innerThought: freezed == innerThought
          ? _value.innerThought
          : innerThought // ignore: cast_nullable_to_non_nullable
              as String?,
      narration: freezed == narration
          ? _value.narration
          : narration // ignore: cast_nullable_to_non_nullable
              as String?,
      imageId: freezed == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl(
      {required this.id,
      required this.timestamp,
      required this.type,
      final List<String>? actions,
      final List<String>? dialogues,
      this.innerThought,
      this.narration,
      this.imageId})
      : _actions = actions,
        _dialogues = dialogues;

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  final MessageType type;
// Content
  final List<String>? _actions;
// Content
  @override
  List<String>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _dialogues;
  @override
  List<String>? get dialogues {
    final value = _dialogues;
    if (value == null) return null;
    if (_dialogues is EqualUnmodifiableListView) return _dialogues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? innerThought;
  @override
  final String? narration;
// Associated Image
  @override
  final String? imageId;

  @override
  String toString() {
    return 'ChatMessage(id: $id, timestamp: $timestamp, type: $type, actions: $actions, dialogues: $dialogues, innerThought: $innerThought, narration: $narration, imageId: $imageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            const DeepCollectionEquality()
                .equals(other._dialogues, _dialogues) &&
            (identical(other.innerThought, innerThought) ||
                other.innerThought == innerThought) &&
            (identical(other.narration, narration) ||
                other.narration == narration) &&
            (identical(other.imageId, imageId) || other.imageId == imageId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      type,
      const DeepCollectionEquality().hash(_actions),
      const DeepCollectionEquality().hash(_dialogues),
      innerThought,
      narration,
      imageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(
      this,
    );
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage(
      {required final String id,
      required final DateTime timestamp,
      required final MessageType type,
      final List<String>? actions,
      final List<String>? dialogues,
      final String? innerThought,
      final String? narration,
      final String? imageId}) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get timestamp;
  @override
  MessageType get type;
  @override // Content
  List<String>? get actions;
  @override
  List<String>? get dialogues;
  @override
  String? get innerThought;
  @override
  String? get narration;
  @override // Associated Image
  String? get imageId;
  @override
  @JsonKey(ignore: true)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeneratedImage _$GeneratedImageFromJson(Map<String, dynamic> json) {
  return _GeneratedImage.fromJson(json);
}

/// @nodoc
mixin _$GeneratedImage {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneratedImageCopyWith<GeneratedImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratedImageCopyWith<$Res> {
  factory $GeneratedImageCopyWith(
          GeneratedImage value, $Res Function(GeneratedImage) then) =
      _$GeneratedImageCopyWithImpl<$Res, GeneratedImage>;
  @useResult
  $Res call({String id, String url, String prompt, DateTime createdAt});
}

/// @nodoc
class _$GeneratedImageCopyWithImpl<$Res, $Val extends GeneratedImage>
    implements $GeneratedImageCopyWith<$Res> {
  _$GeneratedImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? prompt = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeneratedImageImplCopyWith<$Res>
    implements $GeneratedImageCopyWith<$Res> {
  factory _$$GeneratedImageImplCopyWith(_$GeneratedImageImpl value,
          $Res Function(_$GeneratedImageImpl) then) =
      __$$GeneratedImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String url, String prompt, DateTime createdAt});
}

/// @nodoc
class __$$GeneratedImageImplCopyWithImpl<$Res>
    extends _$GeneratedImageCopyWithImpl<$Res, _$GeneratedImageImpl>
    implements _$$GeneratedImageImplCopyWith<$Res> {
  __$$GeneratedImageImplCopyWithImpl(
      _$GeneratedImageImpl _value, $Res Function(_$GeneratedImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? prompt = null,
    Object? createdAt = null,
  }) {
    return _then(_$GeneratedImageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneratedImageImpl implements _GeneratedImage {
  const _$GeneratedImageImpl(
      {required this.id,
      required this.url,
      required this.prompt,
      required this.createdAt});

  factory _$GeneratedImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeneratedImageImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String prompt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'GeneratedImage(id: $id, url: $url, prompt: $prompt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratedImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, prompt, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratedImageImplCopyWith<_$GeneratedImageImpl> get copyWith =>
      __$$GeneratedImageImplCopyWithImpl<_$GeneratedImageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneratedImageImplToJson(
      this,
    );
  }
}

abstract class _GeneratedImage implements GeneratedImage {
  const factory _GeneratedImage(
      {required final String id,
      required final String url,
      required final String prompt,
      required final DateTime createdAt}) = _$GeneratedImageImpl;

  factory _GeneratedImage.fromJson(Map<String, dynamic> json) =
      _$GeneratedImageImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get prompt;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$GeneratedImageImplCopyWith<_$GeneratedImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
