// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_appointment_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$employeeAppointmentVmHash() =>
    r'bc8113efdf7826cd8a995b273eddfc02bc2ce1ae';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EmployeeAppointmentVm
    extends BuildlessAutoDisposeAsyncNotifier<List<AppointmentModel>> {
  late final int userId;
  late final DateTime date;

  Future<List<AppointmentModel>> build(
    int userId,
    DateTime date,
  );
}

/// See also [EmployeeAppointmentVm].
@ProviderFor(EmployeeAppointmentVm)
const employeeAppointmentVmProvider = EmployeeAppointmentVmFamily();

/// See also [EmployeeAppointmentVm].
class EmployeeAppointmentVmFamily
    extends Family<AsyncValue<List<AppointmentModel>>> {
  /// See also [EmployeeAppointmentVm].
  const EmployeeAppointmentVmFamily();

  /// See also [EmployeeAppointmentVm].
  EmployeeAppointmentVmProvider call(
    int userId,
    DateTime date,
  ) {
    return EmployeeAppointmentVmProvider(
      userId,
      date,
    );
  }

  @override
  EmployeeAppointmentVmProvider getProviderOverride(
    covariant EmployeeAppointmentVmProvider provider,
  ) {
    return call(
      provider.userId,
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'employeeAppointmentVmProvider';
}

/// See also [EmployeeAppointmentVm].
class EmployeeAppointmentVmProvider
    extends AutoDisposeAsyncNotifierProviderImpl<EmployeeAppointmentVm,
        List<AppointmentModel>> {
  /// See also [EmployeeAppointmentVm].
  EmployeeAppointmentVmProvider(
    this.userId,
    this.date,
  ) : super.internal(
          () => EmployeeAppointmentVm()
            ..userId = userId
            ..date = date,
          from: employeeAppointmentVmProvider,
          name: r'employeeAppointmentVmProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$employeeAppointmentVmHash,
          dependencies: EmployeeAppointmentVmFamily._dependencies,
          allTransitiveDependencies:
              EmployeeAppointmentVmFamily._allTransitiveDependencies,
        );

  final int userId;
  final DateTime date;

  @override
  bool operator ==(Object other) {
    return other is EmployeeAppointmentVmProvider &&
        other.userId == userId &&
        other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Future<List<AppointmentModel>> runNotifierBuild(
    covariant EmployeeAppointmentVm notifier,
  ) {
    return notifier.build(
      userId,
      date,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
