import 'package:meta/meta.dart';

@immutable
class AuthUser{
  final String uid;
  final String email;
  final String displayName;

  AuthUser({@required this.uid, this.email, this.displayName});

}