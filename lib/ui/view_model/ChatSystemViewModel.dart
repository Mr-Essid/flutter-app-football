

import 'package:flutter/material.dart';
import 'package:project_flutter_football/constaints.dart';
import 'package:project_flutter_football/data/repository/match_repository.dart';
import 'package:project_flutter_football/models/message_on_response_model.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/sesssion_managements.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatSystemViewModel extends ChangeNotifier {

  UiState<List<MessageResponsePayload>> messageLoadingState = IdealState();

  final scrollController = ScrollController();
  final textEditingController = TextEditingController();


  String roomId;
  List<MessageResponsePayload>? listOfMessages_;

  IO.Socket? _socket;
  bool isConnected = false;
  bool isMessagesLoaded = false;
  String message = "Hello There";


  sendMessage() {
    if(textEditingController.text.isNotEmpty && isConnected) {
        _socket?.emit('message', textEditingController.text);
        textEditingController.clear();
    }
  }


  ChatSystemViewModel({required this.roomId})  {

    loadAllMessageX();

    final token = SesssionManagements().getToken();

    token.then((value)  {
      _socket = IO.io('http://$BASE_URL',
          IO.OptionBuilder().setQuery({'roomId': roomId}).disableAutoConnect().setExtraHeaders({'Authorization': 'Bearer $value'}).setTransports(['websocket']).build());
      _socket?.connect();

      _socket?.onConnect((_) {
        isConnected = true;
      });

      _socket?.onDisconnect((_) {
        isConnected = false;
      });

      _socket?.onConnectError((_) {
        print("connection error");
      }
      );

      _socket?.on('response', (data) {
        final response = MessageResponsePayload.fromJsonWithResponse(data);
        listOfMessages_?.insert(0, response);
        notifyListeners();
      });

    });
  }


  loadAllMessageSubmitState(UiState<List<MessageResponsePayload>> submitState) {
   messageLoadingState = submitState;
   notifyListeners();
  }


  resetUiState() {
    messageLoadingState = IdealState();
  }

  loadAllMessageX() async {
    await for(Events<List<MessageResponsePayload>> event in loadAllMessages(roomId) ) {

     if(event is SuccessEvent<List<MessageResponsePayload>>) {
       listOfMessages_ = event.data.reversed.toList(growable: true);
       // success state will be ignored
       loadAllMessageSubmitState(SuccessState(message: event.message ?? "message loaded successfully", onDismis: resetUiState));
       print('all data loaded');
     }

     if(event is ErrorEvent<List<MessageResponsePayload>>) {
       loadAllMessageSubmitState(ErrorState(error: event.error, onDismis: resetUiState));
       print('error ${event.error}');
     }

     if(event is LoadingEvent<List<MessageResponsePayload>>) {
       loadAllMessageSubmitState(LoadingState());
       print('loading state');
     }

    }

  }



  @override
  void dispose() {
    scrollController.dispose();
    textEditingController.dispose();
    _socket?.dispose();
    _socket = null;
    super.dispose();
  }

}