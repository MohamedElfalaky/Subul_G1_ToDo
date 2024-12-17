part of 'registration_cubit.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationImagePicked extends RegistrationState {}
