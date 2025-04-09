import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/feature/home/model/notification_model.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitialState()) {
    on<LoadUserNotificationEvent>(loadUserNotificationEvent);
  }

  FutureOr<void> loadUserNotificationEvent(
    LoadUserNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoadingState());
    final SecureStorageService secureStorageService = SecureStorageService();
    final client = http.Client();

    String? userId = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    String? companyId = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    final url = Uri.parse(getNotificationApiEndPointURl);
    try {
      final response = await client.post(
        url,
        body: {'user_id': userId, 'company_id': companyId},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        NotificationModel notificationModel = NotificationModel.fromJson(
          jsonResponse,
        );
        emit(
          NotificationLoadedSuccessState(notificationModel: notificationModel),
        );
        log('${notificationModel.enquiryData}');
        // notificaton.add(notificationModel);
      }
      // else{

      // }
    } catch (e) {
      emit(NotificationFailedErrorState(error: e.toString()));
      log(e.toString());
    }
  }
}
