import 'package:flutter/material.dart';
import 'package:loja_virtual_8/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,        
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) 
            return Center(child: CircularProgressIndicator(),);

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Nome completo"
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Nome inválido";
                  }, 
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@')) return "Email inválido";
                  }, 
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: "Senha",                
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) return "Senha inválida";
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: "Endereço"
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido";
                  }, 
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    child: Text("Criar conta", style: TextStyle(fontSize: 18.0),),
                    textColor: Colors.white, 
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "addres": _addressController.text
                        };

                        model.signUp(userData: userData, pass: _passController.text, onSuccess: _onSuccess, onFail: _onFail);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }
      )
    );
  }

  void _onSuccess() {

  }

  void _onFail() {
  }
}