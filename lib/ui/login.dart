import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare_superadmin/services/auth_service.dart';


class LoginPage extends StatefulWidget {
  static const String route = '/' ;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController, _pwController;
  FocusNode _emailFocus, _pwFocus;
  TextEditingController resetPassword = new TextEditingController();
  TextStyle style = TextStyle(color: Colors.deepPurple,fontSize: 16);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Initially password is obscure
  bool _obscureText = true;
  String _password;
  String _email;

  bool isValidEmail() {
    if ((_email == null) || (_email.length == 0)) {
      return true;
    }
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
  }

  bool isValidPassword() {
    if ((_password == null) || (_password.length == 0)) {
      return true;
    }
    return (_password.length > 2);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validate() {
    setState(() {
      _email = _emailController.text;
      _password = _pwController.text;
    });
  }

  Future<void> performLogin() async {
    if (_emailController.text.isEmpty ||
        _pwController.text.isEmpty) {
      print("Email and password cannot be empty");
      return;
    }

    try {
      final user = await AuthHelper.signInWithEmail(
          email: _emailController.text,
          password: _pwController.text);
      if ( user != null) {
        print("Login successfull");
      }


    } on Exception catch (e) {
      print(e);
    }

  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _emailFocus = FocusNode();
    _pwFocus = FocusNode();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Container(
                padding: EdgeInsets.only(left: 0, top: 30),
                child: Image.asset(
                  "assets/images/logo2.jpeg",
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: 320,
                color: Colors.grey.withOpacity(0.2),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text("Admin",style: GoogleFonts.cairo(fontSize: 25,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextField(
                          focusNode: _emailFocus,
                          controller: _emailController,
                          obscureText: false,
                          keyboardType:
                          TextInputType.emailAddress, //show email keyboard
                          textInputAction: TextInputAction.next,
                          onSubmitted: (input) {
                            _emailFocus.unfocus();
                            _email = input;
                            FocusScope.of(context).requestFocus(_pwFocus);
                          },
                          onTap: _validate,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              new BorderSide(color: Colors.deepPurpleAccent),
                              borderRadius: new BorderRadius.circular(25.7),
                            ),
                            hintText: 'Email',
                            focusColor: Colors.deepPurpleAccent,
                            hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.deepPurpleAccent,
                            ),
                            errorText:
                            isValidEmail() ? null : "Invalid Email Address",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextField(
                          focusNode: _pwFocus,
                          controller: _pwController,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (input) {
                            _pwFocus.unfocus();
                            _password = input;
                            performLogin();
                          },
                          onTap: _validate,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              new BorderSide(color: Colors.deepPurpleAccent),
                              borderRadius: new BorderRadius.circular(25.7),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.deepPurpleAccent,
                            ),
                            errorText:
                            isValidPassword() ? null : "Password too short.",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.deepPurpleAccent,
                              ),
                              onPressed: _toggle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        performLogin();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left:0,top: 10),
                        child: FlatButton(
                          height: 45,
                          minWidth: 200,
                          color: const Color(0xf0899bf2),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20.0,color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: performLogin,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
