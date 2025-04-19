import 'package:cepnak_agency/authentication/domain/agent.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus {
  authrized,
  unAuthrized,
  registration,
  verfication,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final Agent? agent;
  final String? username;
  const AuthState({
    required this.status,
    this.agent,
    this.username,
  });

  @override
  List<Object?> get props => [status, agent];

  AuthState copyWith({
    AuthStatus? status,
    Agent? agent,
  }) {
    return AuthState(
        status: status ?? this.status,
        agent: agent ?? this.agent,
        );
  }
}
