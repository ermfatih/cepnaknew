import 'package:cepnak/product/models/agent_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';

import 'carrier_model.dart';


enum RequestStatus{
  waiting,
  accepted,
  rejected
}

class RequestModel extends ParseObject implements ParseCloneable, EquatableMixin {
  static const String _keyTableName = 'request';

  RequestModel({
    String? objectId,
    required Agent agentId,
    required Carrier carrierId,
    String? requestState,
    String? message,
  }) : super(_keyTableName) {
    if (objectId != null) {
      this.objectId = objectId;
    }
    set<Carrier>('carrierId', carrierId);
    set<String?>('requestState', requestState);
    set<String?>('message', message);
    set<Agent>('agentId', agentId);
  }
  RequestModel.clone() : this(
    agentId: Agent.clone(),
    carrierId: Carrier.clone(),
    requestState: '',
    message: '',
  );

  @override
  RequestModel clone(Map<String, dynamic> map) => RequestModel.clone()..fromJson(map);



  String? get message => get<String?>('message');

  String? get requestState => get<String?>('requestState');

  Agent get agentId => getAgent();

  Carrier get carrierId => getCarrier();

  Carrier getCarrier() {
    final ParseObject? data = get<ParseObject?>('carrierId');
    if (data != null) {
      return Carrier.clone()..fromJson(data.toJson());
    }
    return Carrier.clone();
  }
  Agent getAgent() {
    final ParseObject? data = get<ParseObject?>('agentId');
    if (data != null) {
      return Agent.clone()..fromJson(data.toJson());
    }
    return Agent.clone();
  }

  @override
  List<Object?> get props => [
    objectId,
    agentId,
    carrierId,
    requestState,
    message,
  ];
  @override
  bool? get stringify => true;
  RequestModel copyWith({
    Agent? agentId,
    Carrier? carrierId,
    String? requestState,
    String? message,
  }) {
    return RequestModel(
        objectId: objectId,
        carrierId: carrierId??this.carrierId,
        agentId: agentId??this.agentId,
        message: message??this.message,
        requestState: requestState??this.requestState
    );
  }
}
