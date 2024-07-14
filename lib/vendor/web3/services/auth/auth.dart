import 'package:split_eth_flutter/vendor/web3/services/api/api.dart';

class HashRequest {
  final List<String> types;
  final List<dynamic> values;

  HashRequest({
    required this.types,
    required this.values,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'types': types,
      'values': values,
    };
  }
}

class HashResponse {
  final String hash;

  HashResponse({
    required this.hash,
  });

  factory HashResponse.fromJson(Map<String, dynamic> json) {
    return HashResponse(
      hash: json['hash'],
    );
  }
}

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

  Future<HashResponse> hash(HashRequest request) async {
    final response = await _apiService.post(
      url: '/hash',
      body: request.toJson(),
    );

    return HashResponse.fromJson(response);
  }

  Future<AuthResponse> request(AuthRequest request) async {
    final response = await _apiService.post(
      url: '/session/request',
      body: request.toJson(),
    );

    return AuthResponse.fromJson(response);
  }
}
