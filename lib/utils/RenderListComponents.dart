
import 'package:flutter/material.dart';


import 'package:project_flutter_football/utils/ui_state.dart';


Widget ShowListWithState<T>(UiState<T> uiState, List<T>? list_, Widget Function(BuildContext, T, Function()) builderWidget) {

  if(uiState is LoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
  }
  else if(uiState is ErrorState<T>) {
    return  Center(
      child: Text(uiState.error),
    );
  }else {
    if(list_ != null) {
      return ListView.builder(itemCount: list_.length, itemBuilder: (context, index) {
        return builderWidget(context, list_[index],  () {});
      });
    }
  }
  return const SizedBox();
}

