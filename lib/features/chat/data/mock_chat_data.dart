// Mock data for the Chat screen.
// Will be replaced with Firestore real-time data in Phase 4.

class MockChatData {
  MockChatData._();

  static const Map<String, dynamic> worker = {
    'name': 'Ramon Dela Cruz',
    'isOnline': true,
  };

  static const List<Map<String, dynamic>> messages = [
    {
      'id': 'm1',
      'text': 'Magandang umaga po! Papunta na po ako sa inyo. Mga 15 minutes po.',
      'isMe': false,
      'time': '9:42 AM',
      'dateHeader': 'Today, 9:41 AM',
    },
    {
      'id': 'm2',
      'text': 'Sige po, Kuya Ramon. Ingat po sa byahe!',
      'isMe': true,
      'time': '9:45 AM',
      'dateHeader': null,
    },
    {
      'id': 'm3',
      'text': 'Dito na po ako sa gate ninyo.',
      'isMe': false,
      'time': '10:02 AM',
      'dateHeader': null,
    },
  ];
}
