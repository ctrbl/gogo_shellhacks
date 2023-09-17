class EmojiMapping {
  static Map<String, String> eventCategoryToEmoji = {
    'restaurant': '🍽️',
    'flight': '🛩️',
    'museum': '🏛️',
    'shopping': '🛍️',
    'attraction': '📸',
    'beauty': '💅🏻',
    'nature': '🍀',
    'sports': '🏅', 
    'religious': '🙏🏻', 
    'boba': '🧋',
    'coffee': '☕️'
  };

  static String getEmojiForCategory(String category) {
    return eventCategoryToEmoji[category] ?? '📍'; 
  }
}