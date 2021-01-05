// For storing our result
class Suggestion {
  final String placeId;
  final String desc;

  Suggestion(this.placeId, this.desc);

  @override
  String toString() {
    print('suggestions working');
    return 'Suggestion(description: $desc, placeId: $placeId)';
  }
}