String limitText(String text, int maxLength) {
  return (text.length <= maxLength)
      ? text
      : '${text.substring(0, maxLength)}...';
}