import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Shop App',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 60,
              ),
              AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// class AuthCard extends StatefulWidget {
//   @override
//   _AuthCardState createState() => _AuthCardState();
// }

// class _AuthCardState extends State<AuthCard>
//     with SingleTickerProviderStateMixin {

// AnimationController _animController;
// Animation<Size> _heightAnimation;

// @override
// void initState() {
//   _animController =
//       AnimationController(duration: Duration(milliseconds: 300), vsync: this);
//   _heightAnimation = Tween<Size>(
//           begin: Size(double.infinity, 350), end: Size(double.infinity, 450))
//       .animate(
//           CurvedAnimation(parent: _animController, curve: Curves.easeIn));
//   _heightAnimation.addListener(() => setState(() {}));
//   super.initState();
// }

// @override
// void dispose() {
//   _animController.dispose();
//   super.dispose();
// }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Container(
//       // decoration: BoxDecoration(
//       //   boxShadow: [
//       //     BoxShadow(color: Colors.black12, blurRadius: 6),
//       //   ],
//       //   color: Colors.white,
//       // ),
//       padding: EdgeInsets.all(20),
//       height: _heightAnimation.value.height,
//       constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
//       // width: deviceSize.width * 0.85,
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//   TextFormField(
//     decoration: InputDecoration(
//       labelText: 'Email',
//       prefixIcon: Icon(Icons.mail),
//     ),
//     keyboardType: TextInputType.emailAddress,
//     textInputAction: TextInputAction.next,
//     validator: (value) {
//       if (value.isEmpty || !value.contains('@')) {
//         return 'Invalid email address.';
//       }
//       return null;
//     },
//     onSaved: (value) {
//       _authData['email'] = value;
//     },
//   ),
//   SizedBox(
//     height: 20,
//   ),
//   TextFormField(
//     decoration: InputDecoration(
//       labelText: 'Password',
//       prefixIcon: Icon(Icons.vpn_key),
//     ),
//     textInputAction: _authMode == AuthMode.Signup
//         ? TextInputAction.next
//         : TextInputAction.done,
//     obscureText: true,
//     controller: _passwordController,
//     validator: (value) {
//       if (value.isEmpty || value.length < 8) {
//         return 'Password have to be at least 8 characters long.';
//       }
//       return null;
//     },
//     onSaved: (value) {
//       _authData['password'] = value;
//     },
//   ),
//   SizedBox(
//     height: 20,
//   ),
//   if (_authMode == AuthMode.Signup)
//     TextFormField(
//       enabled: _authMode == AuthMode.Signup,
//       decoration: InputDecoration(
//         labelText: 'Confirm password',
//         prefixIcon: Icon(Icons.vpn_key),
//       ),
//       obscureText: true,
//       validator: _authMode == AuthMode.Signup
//           ? (value) {
//               if (value != _passwordController.text) {
//                 return 'Passwords do not match.';
//               }
//               return null;
//             }
//           : null,
//     ),
//   SizedBox(height: 20),
//   Spacer(),
//   if (_isLoading)
//     CircularProgressIndicator()
//   else
//     RaisedButton(
//       onPressed: _submitForm,
//       color: Theme.of(context).accentColor,
//       textColor: Colors.white,
//       child: Text(
//         _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//     ),
//   FlatButton(
//     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     onPressed: _switchAuthMode,
//     child: Text(
//       _authMode == AuthMode.Login
//           ? 'Don\'t have an account? Signup'
//           : 'Already have an account? Login',
//     ),
//   ),
//   SizedBox(height: 20),
// ],
//         ),
//       ),
//     );
//   }
// }
