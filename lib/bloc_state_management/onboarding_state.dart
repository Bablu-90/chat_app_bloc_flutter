part of 'onboarding_cubit.dart';

@immutable
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {
  @override
  List<Object> get props => [];
}

class OnboardingLoading extends OnboardingState {
  @override
  List<Object> get props => [];
}

class OnboardingSuccess extends OnboardingState {
  final UserModel user;

  OnboardingSuccess(this.user);
  @override
  List<Object> get props => [user];
}
