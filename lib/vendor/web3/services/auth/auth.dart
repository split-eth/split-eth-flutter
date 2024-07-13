import 'package:split_eth_flutter/vendor/web3/services/api/api.dart';

class AuthRequest {
  final String secondFactor;
  final String sessionAddress;
  final String signature;

  AuthRequest({
    required this.secondFactor,
    required this.sessionAddress,
    required this.signature,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'secondFactor': secondFactor,
      'sessionAddress': sessionAddress,
      'signature': signature,
    };
  }
}

class AuthResponse {
  final String provider;
  final String salt;
  final String sessionAddress;
  final String signature;

  AuthResponse({
    required this.provider,
    required this.salt,
    required this.sessionAddress,
    required this.signature,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      provider: json['provider'],
      salt: json['salt'],
      sessionAddress: json['sessionAddress'],
      signature: json['signature'],
    );
  }
}

class AuthService {
  final APIService _apiService;

  AuthService({required APIService apiService}) : _apiService = apiService;

  Future<AuthResponse> request(AuthRequest request) async {
    final response = await _apiService.post(
      url: '/session/request',
      body: request.toJson(),
    );

    return AuthResponse.fromJson(response);
  }
}
