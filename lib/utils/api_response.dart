import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final dynamic status;
  final dynamic data;
  final String message;
  final String messageKey;
  final String messages;
  final int statusCode;
  final bool isRedirectToHome;

  const ApiResponse({
    this.status,
    this.data,
    this.message,
    this.messageKey,
    this.messages,
    this.statusCode,
    this.isRedirectToHome: false,
  });
  @override
  List<Object> get props => [
        data,
        message,
        messageKey,
        statusCode,
        messages,
        status,
        isRedirectToHome
      ];

  // String toString() =>
  //     '{status:$status, data:$data, statuCode: $statusCode, message:$message, messageKey: $messageKey, messages:$messages, isRedirectToHome: $isRedirectToHome}';
}
