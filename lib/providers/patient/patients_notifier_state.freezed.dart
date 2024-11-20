// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patients_notifier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PatientsNotifierState {
  List<Patient> get patients =>
      throw _privateConstructorUsedError; // List of patients
  bool get isLoading => throw _privateConstructorUsedError; // Loading state
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of PatientsNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientsNotifierStateCopyWith<PatientsNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientsNotifierStateCopyWith<$Res> {
  factory $PatientsNotifierStateCopyWith(PatientsNotifierState value,
          $Res Function(PatientsNotifierState) then) =
      _$PatientsNotifierStateCopyWithImpl<$Res, PatientsNotifierState>;
  @useResult
  $Res call({List<Patient> patients, bool isLoading, String? errorMessage});
}

/// @nodoc
class _$PatientsNotifierStateCopyWithImpl<$Res,
        $Val extends PatientsNotifierState>
    implements $PatientsNotifierStateCopyWith<$Res> {
  _$PatientsNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientsNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patients = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      patients: null == patients
          ? _value.patients
          : patients // ignore: cast_nullable_to_non_nullable
              as List<Patient>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientsNotifierStateImplCopyWith<$Res>
    implements $PatientsNotifierStateCopyWith<$Res> {
  factory _$$PatientsNotifierStateImplCopyWith(
          _$PatientsNotifierStateImpl value,
          $Res Function(_$PatientsNotifierStateImpl) then) =
      __$$PatientsNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Patient> patients, bool isLoading, String? errorMessage});
}

/// @nodoc
class __$$PatientsNotifierStateImplCopyWithImpl<$Res>
    extends _$PatientsNotifierStateCopyWithImpl<$Res,
        _$PatientsNotifierStateImpl>
    implements _$$PatientsNotifierStateImplCopyWith<$Res> {
  __$$PatientsNotifierStateImplCopyWithImpl(_$PatientsNotifierStateImpl _value,
      $Res Function(_$PatientsNotifierStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientsNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patients = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$PatientsNotifierStateImpl(
      patients: null == patients
          ? _value._patients
          : patients // ignore: cast_nullable_to_non_nullable
              as List<Patient>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PatientsNotifierStateImpl implements _PatientsNotifierState {
  const _$PatientsNotifierStateImpl(
      {final List<Patient> patients = const [],
      this.isLoading = false,
      this.errorMessage})
      : _patients = patients;

  final List<Patient> _patients;
  @override
  @JsonKey()
  List<Patient> get patients {
    if (_patients is EqualUnmodifiableListView) return _patients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_patients);
  }

// List of patients
  @override
  @JsonKey()
  final bool isLoading;
// Loading state
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'PatientsNotifierState(patients: $patients, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientsNotifierStateImpl &&
            const DeepCollectionEquality().equals(other._patients, _patients) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_patients), isLoading, errorMessage);

  /// Create a copy of PatientsNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientsNotifierStateImplCopyWith<_$PatientsNotifierStateImpl>
      get copyWith => __$$PatientsNotifierStateImplCopyWithImpl<
          _$PatientsNotifierStateImpl>(this, _$identity);
}

abstract class _PatientsNotifierState implements PatientsNotifierState {
  const factory _PatientsNotifierState(
      {final List<Patient> patients,
      final bool isLoading,
      final String? errorMessage}) = _$PatientsNotifierStateImpl;

  @override
  List<Patient> get patients; // List of patients
  @override
  bool get isLoading; // Loading state
  @override
  String? get errorMessage;

  /// Create a copy of PatientsNotifierState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientsNotifierStateImplCopyWith<_$PatientsNotifierStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
