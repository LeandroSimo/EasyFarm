import 'package:easyfarm/src/models/http_exception.dart';
import 'package:easyfarm/src/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .signIn(_authData['email'], _authData['password']);
    } on HttpException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(error.message),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
              'Falha ao se conextar com o servidor, verifique a sua conexão com a internet!'),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 166, 74, 1),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: screenSize.width * 0.8,
                height: 330.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.7,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: _isLoading
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            enabled: !_isLoading,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Digite o seu email!';
                              } else if (!value.contains('@')) {
                                return 'Email invalido!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: TextFormField(
                              enabled: !_isLoading,
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Digite sua senha!';
                                } else if (value.length < 5) {
                                  return 'Senha Muito curta!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: 'Senha',
                              ),
                            ),
                          ),
                          _isLoading
                              ? Container()
                              : ElevatedButton(
                                  onPressed: _submit,
                                  child: Text('Entrar'),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _isLoading
              ? Positioned(
                  bottom: 40.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
