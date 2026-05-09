// Mock data for the Worker Chat screen.
// Same design concept as user chat but from worker's perspective.
// Will be replaced with Firestore real-time data in Phase 4.

class MockWorkerChatData {
  MockWorkerChatData._();

  /// The client the worker is chatting with
  static const Map<String, dynamic> client = {
    'name': 'Maria Santos',
    'isOnline': true,
  };

  /// Messages from the worker's point of view
  /// isMe = true means the worker (current user) sent it
  /// isMe = false means the client sent it
  static const List<Map<String, dynamic>> messages = [
    {
      'id': 'm1',
      'text': 'Hi po! Confirmed na po yung booking niyo for pipe leak repair. See you later po.',
      'isMe': true,
      'time': '1:30 PM',
      'dateHeader': 'Today, 1:28 PM',
    },
    {
      'id': 'm2',
      'text': 'Okay po, salamat! Nasa bahay lang po ako buong hapon.',
      'isMe': false,
      'time': '1:32 PM',
      'dateHeader': null,
    },
    {
      'id': 'm3',
      'text': 'Papunta na po ako. Mga 20 minutes po.',
      'isMe': true,
      'time': '1:45 PM',
      'dateHeader': null,
    },
    {
      'id': 'm4',
      'text': 'Sige po, dito lang po ako. Ingat po sa daan!',
      'isMe': false,
      'time': '1:46 PM',
      'dateHeader': null,
    },
    {
      'id': 'm5',
      'text': 'Nandito na po ako sa gate niyo.',
      'isMe': true,
      'time': '2:05 PM',
      'dateHeader': null,
    },
  ];
}
