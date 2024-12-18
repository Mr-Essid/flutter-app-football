import 'package:event_bus/event_bus.dart';

// it's simple stream controller => global object
EventBus eventBus = EventBus();

enum SimpleEventData {
  ADD_MATCH_EVENT,
  JOIN_MATCH_EVENT,
  JOINED_MATCH_EVENT,
  UNJOIN_MATCH_EVEN

}

class BEvent<T> {
   T resource;
   String message;
  BEvent({required this.resource, required this.message});
}