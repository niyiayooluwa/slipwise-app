import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ticket_selection_provider.g.dart';

@riverpod
class TicketSelection extends _$TicketSelection {
  @override
  Set<String> build() => {};

  bool get isSelectionMode => state.isNotEmpty;

  bool isSelected(String ticketId) => state.contains(ticketId);

  void toggle(String ticketId) {
    if (state.contains(ticketId)) {
      state = {...state}..remove(ticketId);
    } else {
      state = {...state, ticketId};
    }
  }

  void select(String ticketId) {
    state = {...state, ticketId};
  }

  void deselect(String ticketId) {
    state = {...state}..remove(ticketId);
  }

  void selectAll(Iterable<String> ticketIds) {
    state = {...ticketIds};
  }

  void clear() {
    state = {};
  }
}
