part of 'notification_bloc.dart';

sealed class NotificationState {}

final class NotificationInitialState extends NotificationState {}

final class NotificationLoadingState extends NotificationState {}

final class NotificationLoadedSuccessState extends NotificationState {
  final NotificationModel notificationModel;

  NotificationLoadedSuccessState({required this.notificationModel});
}

final class NotificationFailedErrorState extends NotificationState {
  final String error;

  NotificationFailedErrorState({required this.error});
}
