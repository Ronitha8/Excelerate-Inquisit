// lib/user_progress.dart
import 'models/program_model.dart';

class UserProgress {
  // === DATA STORAGE ===
  static final List<Program> _enrolled = [];
  static final List<Program> _favorites = [];
  static final List<NotificationItem> _notifications = [];
  static final Map<String, int> _timeSpent = {};
  static final List<ChatContact> _chats = [];

  // === ENROLLED ===
  static List<Program> get enrolled => List.unmodifiable(_enrolled);
  static void enroll(Program program) {
    if (!_enrolled.contains(program)) {
      _enrolled.add(program);
      _addNotification(
        'Enrolled in "${program.title}"',
        NotificationType.enroll,
        program,
      );
    }
  }

  static void unenroll(Program program) => _enrolled.remove(program);
  static bool isEnrolled(Program program) => _enrolled.contains(program);

  // === FAVORITES ===
  static List<Program> get favorites => List.unmodifiable(_favorites);
  static void add(Program program) {
    if (!_favorites.contains(program)) {
      _favorites.add(program);
      _addNotification(
        'Added "${program.title}" to favorites',
        NotificationType.favorite,
        program,
      );
    }
  }

  static void remove(Program program) => _favorites.remove(program);
  static bool isFavorited(Program program) => _favorites.contains(program);

  // === TIME SPENT ===
  static void logTime(Program program, int minutes) {
    final id = program.id;
    _timeSpent[id] = (_timeSpent[id] ?? 0) + minutes;
  }

  static int getTimeSpent(Program program) {
    final id = program.id;
    return _timeSpent[id] ?? 0;
  }

  // === CHAT SYSTEM ===
  static List<ChatContact> get chats {
    final sorted = List<ChatContact>.from(_chats);
    sorted.sort((a, b) {
      final aScore =
          (a.unreadCount * 10) +
          (a.lastMessageTime?.millisecondsSinceEpoch ?? 0);
      final bScore =
          (b.unreadCount * 10) +
          (b.lastMessageTime?.millisecondsSinceEpoch ?? 0);
      return bScore.compareTo(aScore);
    });
    return sorted;
  }

  static void sendMessage(String userId, String message, {Program? program}) {
    final contact = _chats.firstWhere(
      (c) => c.userId == userId,
      orElse: () => ChatContact(
        userId: userId,
        name: userId.split('@').first,
        avatar: 'assets/images/male_avatar.png',
        bio: 'Aspiring learner',
      ),
    );

    if (!_chats.contains(contact)) {
      _chats.add(contact);
    }

    contact.messages.add(
      ChatMessage(text: message, isSent: true, timestamp: DateTime.now()),
    );
    contact.unreadCount = 0;
    contact.lastMessageTime = DateTime.now();

    // Simulate reply
    Future.delayed(const Duration(seconds: 1), () {
      contact.messages.add(
        ChatMessage(
          text: 'Thanks! Working on it!',
          isSent: false,
          timestamp: DateTime.now(),
        ),
      );
      contact.unreadCount++;
      _addNotification(
        '$userId sent you a message',
        NotificationType.message,
        program,
      );
    });
  }

  // === NOTIFICATIONS ===
  static List<NotificationItem> get notifications =>
      List.from(_notifications.reversed);

  static int get unreadCount {
    final notifCount = _notifications.where((n) => !n.read).length;
    final chatCount = _chats.fold(0, (sum, c) => sum + c.unreadCount);
    return notifCount + chatCount;
  }

  static void _addNotification(
    String message,
    NotificationType type,
    Program? program,
  ) {
    _notifications.add(
      NotificationItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message,
        type: type,
        program: program,
        timestamp: DateTime.now(),
        read: false, // Always unread initially
      ),
    );
  }

  static void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].read = true;
    }
    // Reduce unreadCount for chats too
    for (var c in _chats) {
      c.unreadCount = 0;
    }
  }

  static void clearAll() => _notifications.clear();
}

// === ENUMS & MODELS ===
enum NotificationType { enroll, favorite, message, system }

class NotificationItem {
  final String id;
  final String message;
  final NotificationType type;
  final Program? program;
  final DateTime timestamp;
  bool read = false;

  NotificationItem({
    required this.id,
    required this.message,
    required this.type,
    this.program,
    required this.timestamp,
    required this.read,
  });
}

class ChatContact {
  final String userId;
  final String name;
  final String avatar;
  final String bio;
  final List<ChatMessage> messages = [];
  int unreadCount = 0;
  DateTime? lastMessageTime;

  ChatContact({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.bio,
  });
}

class ChatMessage {
  final String text;
  final bool isSent;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isSent,
    required this.timestamp,
  });
}
