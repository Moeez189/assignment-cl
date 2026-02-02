// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PostWithUser {
  Post get post => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  bool get isBookmarked => throw _privateConstructorUsedError;

  /// Create a copy of PostWithUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostWithUserCopyWith<PostWithUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostWithUserCopyWith<$Res> {
  factory $PostWithUserCopyWith(
    PostWithUser value,
    $Res Function(PostWithUser) then,
  ) = _$PostWithUserCopyWithImpl<$Res, PostWithUser>;
  @useResult
  $Res call({Post post, User? user, bool isBookmarked});

  $PostCopyWith<$Res> get post;
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$PostWithUserCopyWithImpl<$Res, $Val extends PostWithUser>
    implements $PostWithUserCopyWith<$Res> {
  _$PostWithUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostWithUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
    Object? user = freezed,
    Object? isBookmarked = null,
  }) {
    return _then(
      _value.copyWith(
            post:
                null == post
                    ? _value.post
                    : post // ignore: cast_nullable_to_non_nullable
                        as Post,
            user:
                freezed == user
                    ? _value.user
                    : user // ignore: cast_nullable_to_non_nullable
                        as User?,
            isBookmarked:
                null == isBookmarked
                    ? _value.isBookmarked
                    : isBookmarked // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of PostWithUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res> get post {
    return $PostCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value) as $Val);
    });
  }

  /// Create a copy of PostWithUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostWithUserImplCopyWith<$Res>
    implements $PostWithUserCopyWith<$Res> {
  factory _$$PostWithUserImplCopyWith(
    _$PostWithUserImpl value,
    $Res Function(_$PostWithUserImpl) then,
  ) = __$$PostWithUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Post post, User? user, bool isBookmarked});

  @override
  $PostCopyWith<$Res> get post;
  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$PostWithUserImplCopyWithImpl<$Res>
    extends _$PostWithUserCopyWithImpl<$Res, _$PostWithUserImpl>
    implements _$$PostWithUserImplCopyWith<$Res> {
  __$$PostWithUserImplCopyWithImpl(
    _$PostWithUserImpl _value,
    $Res Function(_$PostWithUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostWithUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
    Object? user = freezed,
    Object? isBookmarked = null,
  }) {
    return _then(
      _$PostWithUserImpl(
        post:
            null == post
                ? _value.post
                : post // ignore: cast_nullable_to_non_nullable
                    as Post,
        user:
            freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                    as User?,
        isBookmarked:
            null == isBookmarked
                ? _value.isBookmarked
                : isBookmarked // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$PostWithUserImpl extends _PostWithUser {
  const _$PostWithUserImpl({
    required this.post,
    this.user,
    this.isBookmarked = false,
  }) : super._();

  @override
  final Post post;
  @override
  final User? user;
  @override
  @JsonKey()
  final bool isBookmarked;

  @override
  String toString() {
    return 'PostWithUser(post: $post, user: $user, isBookmarked: $isBookmarked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostWithUserImpl &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post, user, isBookmarked);

  /// Create a copy of PostWithUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostWithUserImplCopyWith<_$PostWithUserImpl> get copyWith =>
      __$$PostWithUserImplCopyWithImpl<_$PostWithUserImpl>(this, _$identity);
}

abstract class _PostWithUser extends PostWithUser {
  const factory _PostWithUser({
    required final Post post,
    final User? user,
    final bool isBookmarked,
  }) = _$PostWithUserImpl;
  const _PostWithUser._() : super._();

  @override
  Post get post;
  @override
  User? get user;
  @override
  bool get isBookmarked;

  /// Create a copy of PostWithUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostWithUserImplCopyWith<_$PostWithUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PostsState {
  PostsStatus get status => throw _privateConstructorUsedError;
  List<PostWithUser> get posts => throw _privateConstructorUsedError;
  Set<int> get bookmarkedIds => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get showBookmarksOnly => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of PostsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostsStateCopyWith<PostsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsStateCopyWith<$Res> {
  factory $PostsStateCopyWith(
    PostsState value,
    $Res Function(PostsState) then,
  ) = _$PostsStateCopyWithImpl<$Res, PostsState>;
  @useResult
  $Res call({
    PostsStatus status,
    List<PostWithUser> posts,
    Set<int> bookmarkedIds,
    String searchQuery,
    bool showBookmarksOnly,
    String? errorMessage,
  });
}

/// @nodoc
class _$PostsStateCopyWithImpl<$Res, $Val extends PostsState>
    implements $PostsStateCopyWith<$Res> {
  _$PostsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? posts = null,
    Object? bookmarkedIds = null,
    Object? searchQuery = null,
    Object? showBookmarksOnly = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as PostsStatus,
            posts:
                null == posts
                    ? _value.posts
                    : posts // ignore: cast_nullable_to_non_nullable
                        as List<PostWithUser>,
            bookmarkedIds:
                null == bookmarkedIds
                    ? _value.bookmarkedIds
                    : bookmarkedIds // ignore: cast_nullable_to_non_nullable
                        as Set<int>,
            searchQuery:
                null == searchQuery
                    ? _value.searchQuery
                    : searchQuery // ignore: cast_nullable_to_non_nullable
                        as String,
            showBookmarksOnly:
                null == showBookmarksOnly
                    ? _value.showBookmarksOnly
                    : showBookmarksOnly // ignore: cast_nullable_to_non_nullable
                        as bool,
            errorMessage:
                freezed == errorMessage
                    ? _value.errorMessage
                    : errorMessage // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostsStateImplCopyWith<$Res>
    implements $PostsStateCopyWith<$Res> {
  factory _$$PostsStateImplCopyWith(
    _$PostsStateImpl value,
    $Res Function(_$PostsStateImpl) then,
  ) = __$$PostsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PostsStatus status,
    List<PostWithUser> posts,
    Set<int> bookmarkedIds,
    String searchQuery,
    bool showBookmarksOnly,
    String? errorMessage,
  });
}

/// @nodoc
class __$$PostsStateImplCopyWithImpl<$Res>
    extends _$PostsStateCopyWithImpl<$Res, _$PostsStateImpl>
    implements _$$PostsStateImplCopyWith<$Res> {
  __$$PostsStateImplCopyWithImpl(
    _$PostsStateImpl _value,
    $Res Function(_$PostsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? posts = null,
    Object? bookmarkedIds = null,
    Object? searchQuery = null,
    Object? showBookmarksOnly = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$PostsStateImpl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as PostsStatus,
        posts:
            null == posts
                ? _value._posts
                : posts // ignore: cast_nullable_to_non_nullable
                    as List<PostWithUser>,
        bookmarkedIds:
            null == bookmarkedIds
                ? _value._bookmarkedIds
                : bookmarkedIds // ignore: cast_nullable_to_non_nullable
                    as Set<int>,
        searchQuery:
            null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                    as String,
        showBookmarksOnly:
            null == showBookmarksOnly
                ? _value.showBookmarksOnly
                : showBookmarksOnly // ignore: cast_nullable_to_non_nullable
                    as bool,
        errorMessage:
            freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$PostsStateImpl extends _PostsState {
  const _$PostsStateImpl({
    this.status = PostsStatus.initial,
    final List<PostWithUser> posts = const [],
    final Set<int> bookmarkedIds = const {},
    this.searchQuery = '',
    this.showBookmarksOnly = false,
    this.errorMessage,
  }) : _posts = posts,
       _bookmarkedIds = bookmarkedIds,
       super._();

  @override
  @JsonKey()
  final PostsStatus status;
  final List<PostWithUser> _posts;
  @override
  @JsonKey()
  List<PostWithUser> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  final Set<int> _bookmarkedIds;
  @override
  @JsonKey()
  Set<int> get bookmarkedIds {
    if (_bookmarkedIds is EqualUnmodifiableSetView) return _bookmarkedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_bookmarkedIds);
  }

  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool showBookmarksOnly;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'PostsState(status: $status, posts: $posts, bookmarkedIds: $bookmarkedIds, searchQuery: $searchQuery, showBookmarksOnly: $showBookmarksOnly, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            const DeepCollectionEquality().equals(
              other._bookmarkedIds,
              _bookmarkedIds,
            ) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.showBookmarksOnly, showBookmarksOnly) ||
                other.showBookmarksOnly == showBookmarksOnly) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_posts),
    const DeepCollectionEquality().hash(_bookmarkedIds),
    searchQuery,
    showBookmarksOnly,
    errorMessage,
  );

  /// Create a copy of PostsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostsStateImplCopyWith<_$PostsStateImpl> get copyWith =>
      __$$PostsStateImplCopyWithImpl<_$PostsStateImpl>(this, _$identity);
}

abstract class _PostsState extends PostsState {
  const factory _PostsState({
    final PostsStatus status,
    final List<PostWithUser> posts,
    final Set<int> bookmarkedIds,
    final String searchQuery,
    final bool showBookmarksOnly,
    final String? errorMessage,
  }) = _$PostsStateImpl;
  const _PostsState._() : super._();

  @override
  PostsStatus get status;
  @override
  List<PostWithUser> get posts;
  @override
  Set<int> get bookmarkedIds;
  @override
  String get searchQuery;
  @override
  bool get showBookmarksOnly;
  @override
  String? get errorMessage;

  /// Create a copy of PostsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostsStateImplCopyWith<_$PostsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
