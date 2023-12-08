import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error_handler.freezed.dart';

@freezed
class APIError with _$APIError {
  const factory APIError.noInternetConnection() = _NoInternetConnection;
  const factory APIError.notFound() = _NotFound;
  const factory APIError.unknown() = _Unknown;
}

extension APIErrorMessage on APIError {
  String get message => when(
    noInternetConnection: () => "Pas de connexion Internet",
    notFound: () => 'Resource non trouvée',
    unknown: () => 'Erreur inconnue',
  );
}