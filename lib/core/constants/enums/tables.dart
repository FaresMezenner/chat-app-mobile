enum Tables {
  contacts,
  messages;

  String getName() => toString().split('.').last;
}
