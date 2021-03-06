import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  AnimationController _animController;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    _animController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occurred!'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OKAY'),
          ),
        ],
      ),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Signup) {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animController.reverse();
    } else {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animController.forward();
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState.save();
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed.';
      if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      } else if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already taken.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find user with this email address.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: deviceSize.width * 0.8,
        height: _authMode == AuthMode.Login ? 350 : 450,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email address.';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.vpn_key),
              ),
              textInputAction: _authMode == AuthMode.Signup
                  ? TextInputAction.next
                  : TextInputAction.done,
              obscureText: true,
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty || value.length < 8) {
                  return 'Password have to be at least 8 characters long.';
                }
                return null;
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedContainer(
              constraints: BoxConstraints(
                minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
              ),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: TextFormField(
                  enabled: _authMode == AuthMode.Signup,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        }
                      : null,
                ),
              ),
            ),
            SizedBox(height: 50),
            if (_isLoading)
              CircularProgressIndicator()
            else
              RaisedButton(
                onPressed: _submitForm,
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text(
                  _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: _switchAuthMode,
              child: Text(
                _authMode == AuthMode.Login
                    ? 'Don\'t have an account? Signup'
                    : 'Already have an account? Login',
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
