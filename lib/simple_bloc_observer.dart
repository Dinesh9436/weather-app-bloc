import 'package:flutter_bloc/flutter_bloc.dart';

/// A simple BLoC observer that logs various BLoC-related events to the console.
///
/// This observer is used for debugging and development purposes to track:
/// * Events being added to BLoCs
/// * State changes in BLoCs and Cubits
/// * Transitions between states
/// * Errors occurring in BLoCs
///
/// This is particularly useful for understanding the flow of data and debugging state management
/// issues in the application during development.
class SimpleBlocObserver extends BlocObserver {
  /// Called whenever an event is added to any Bloc.
  ///
  /// This method logs the event that was added to help track the flow of events
  /// through the application.
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Event: $event');
  }

  /// Called whenever a change occurs in any Bloc or Cubit.
  ///
  /// A change consists of both the current state and next state, allowing us to track
  /// how the state evolves over time.
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('Change: $change');
  }

  /// Called whenever a transition occurs in any Bloc.
  ///
  /// A transition consists of the current state, the event, and the next state,
  /// providing a complete picture of a state change.
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('Transition: $transition');
  }

  /// Called whenever an error occurs in any Bloc or Cubit.
  ///
  /// This method helps identify and debug errors that occur during state management.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('Error: $error');
  }
}
