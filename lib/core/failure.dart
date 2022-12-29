import 'package:equatable/equatable.dart';
import 'package:flutter_project_tools/core/utils/locator.dart';
import 'package:flutter_project_tools/flutter_project_tools.dart';
import 'package:flutter_project_tools/services/overlay_service.dart';
import 'overlay.contract.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message});

  @override
  List<Object?> get props => [
        message,
      ];
}

abstract class Success extends Equatable {
  final String? message;
  final dynamic responseData;

  const Success({
    this.message,
    this.responseData,
  });

  @override
  List<Object?> get props => [
        message,
        responseData,
      ];
}

class RequestSuccess extends Success {
  const RequestSuccess({
    String? message,
    dynamic responseData,
  }) : super(
          message: message,
          responseData: responseData,
        );
}

/// Other Failure

class ServerFailure extends Failure {}

class NotFound extends Failure {
  const NotFound({String? message}) : super(message: message);
}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

NotFound onNoConnection() {
  const message = 'Internet connection not found!';
  injector<OverlayService>().showSnackbar(
    message: message,
    alertType: SnackbarType.failed,
  );
  return const NotFound(message: message);
}

NotFound onFailure(dynamic e, {String? title}) {
  dynamic message;
  if (e == null) {
    message = 'Operation failed!';
  } else if (e is String) {
    message = e;
  } else if (e is List<Map<String, dynamic>>) {
    e.map((element) {
      message = element.values.map((e) => '${e.toString()}\n').toList().join('');
    });
  } else if (e is Map<String, dynamic>) {
    message = e.values.map((e) => '${e.toString()}\n').toList().join('');
  } else {
    return message;
  }
  injector<OverlayService>().showSnackbar(
    message: message,
    title: title,
    alertType: SnackbarType.failed,
  );
  return NotFound(message: message);
}

NotFound resIfNull() {
  return const NotFound(
    message: 'Operation failed',
  );
}
