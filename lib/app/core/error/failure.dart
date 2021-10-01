class Failure {
  final String message;
  const Failure({required this.message});
  
  @override
  String toString() {
    return message;
  }
}