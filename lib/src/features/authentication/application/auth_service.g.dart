// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceTokenHash() => r'b3c30ca7134da2f1156b71a1bde9c7461ae0d8fb';

/// See also [authServiceToken].
@ProviderFor(authServiceToken)
final authServiceTokenProvider = AutoDisposeFutureProvider<String?>.internal(
  authServiceToken,
  name: r'authServiceTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authServiceTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthServiceTokenRef = AutoDisposeFutureProviderRef<String?>;
String _$authServiceHash() => r'35abbf338cc195987c8bd08244c586c56b969695';

/// See also [AuthService].
@ProviderFor(AuthService)
final authServiceProvider =
    AutoDisposeNotifierProvider<AuthService, String?>.internal(
  AuthService.new,
  name: r'authServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthService = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
