

import 'package:flutter/material.dart';
import 'package:project_flutter_football/constaints.dart';
import 'package:project_flutter_football/models/message_on_response_model.dart';
import 'package:project_flutter_football/ui/features/shared/ErrorStateComponent.dart';
import 'package:project_flutter_football/ui/view_model/ChatSystemViewModel.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/dashboard_view_model/scaffold_dashbaord_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';

class ChatRoomComponent extends StatefulWidget {
  const ChatRoomComponent({super.key});

  @override
  State<ChatRoomComponent> createState() => _ChatRoomComponentState();
}

class _ChatRoomComponentState extends State<ChatRoomComponent> {
  @override
  Widget build(BuildContext context) {

    UiState<List<MessageResponsePayload>> currentState  = context.watch<ChatSystemViewModel>().messageLoadingState;
    List<MessageResponsePayload>? messagesList  = context.watch<ChatSystemViewModel>().listOfMessages_;
    ChatSystemViewModel viewModelInstance = Provider.of<ChatSystemViewModel>(context, listen: false);
    final currentUser = context.watch<DashboardScaffoldViewModel>().user!;

    FocusNode focusNode = FocusNode();
    return Scaffold(
        appBar: AppBar(title: const Text("Match Messages"),),
        body: Column(
          children: [
           if(currentState is ErrorState<List<MessageResponsePayload>>)
             Expanded(child: Center(child: ErrorStateComponent(message: currentState.error, onRetry: viewModelInstance.loadAllMessageX,)))
            else if(currentState is LoadingState<List<MessageResponsePayload>>)
              const Expanded(
                child:  Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if(messagesList != null && currentState is SuccessState<List<MessageResponsePayload>>)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                         controller: viewModelInstance.scrollController,
                          reverse: true, itemCount: messagesList.length, itemBuilder: (context, index) {
                       final currentItem = messagesList[index];

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              child: ListTile(
                                  title:
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                      const Icon(Icons.account_circle_outlined, size: 28,),
                                      const SizedBox(width: 4,),
                                      Text( (!currentUser.isOwnResource(currentItem.userId))? currentItem.userName.capitalize() : "Me", style: Theme.of(context).textTheme.titleSmall,)],
                                    ),
                                  ),
                                  subtitle: Text(currentItem.content),
                                tileColor: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        );

                      }),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2
                    ),
                    child: TextField(
                      focusNode: focusNode,
                      controller: viewModelInstance.textEditingController,
                      decoration:  InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              viewModelInstance.sendMessage();
                            },
                            icon: const  Icon(Icons.send)),
                        border: const OutlineInputBorder(),
                        hintText: "Message..."
                      ),
                    ),
                    )
                  ],
                ),
              )

          ],
        )
      );
  }
}
