import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:paani/screens/customersideapp/googlemaps/G_Map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanySignupScreen extends StatefulWidget {
  @override
  _CompanySignupScreenState createState() => _CompanySignupScreenState();
}

class _CompanySignupScreenState extends State<CompanySignupScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _email, _password;
  String _cpassword;
  String _name, _contact, _address, _ntnnumber;
  Map _location;

  bool _obscurePassword = true;
  bool pageloading = false;
  bool locationset = false;

  Future<bool> _verifyEmail() async {
    try {
      var response = await http.post(
        'https://seg27-paani-backend.herokuapp.com/users/register/',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Content-Type": "application/json",
        },
        body: json.encode({
          'email': _email,
          'password': _password,
          'name': _name,
          'contact_number': _contact,
          'address': _address,
          'ntn': _ntnnumber,
          'location': jsonEncode(_location),
          'account_type': "COMPANY",
        }),
      );
      var message = json.decode(response.body);
      if (message["error"] == false) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userid', '${message['msg']}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void _submit() async {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      if (_location != null) {
        if (await _verifyEmail()) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/RegisterTanker', ModalRoute.withName('/'));
        } else {
          _showSnackBar("Sorry could not create your account");
        }
      } else {
        _showSnackBar("Please Set your current location");
      }
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),
    ));
  }

  Widget build(BuildContext context) {
    Widget DetailsForm = Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Company Name is required';
            }
            return null;
          },
          onSaved: (text) => _name = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Company Name',
            hintText: 'Company Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (EmailValidator.validate(text) == false) {
              return 'invalid Email-address';
            }
            return null;
          },
          onSaved: (text) => _email = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'email@email.com',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Contact Number is required';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _contact = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contact',
            hintText: 'Contact Number',
            prefixIcon: Icon(Icons.contact_phone),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty || text.length != 7) {
              return 'Invalid NTN number';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _ntnnumber = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'NTN Number',
            hintText: '7 digits (without dashes)',
            prefixIcon: Icon(Icons.contact_phone),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Address is required';
            }
            return null;
          },
          onSaved: (text) => _address = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Address',
            hintText: 'Address',
            prefixIcon: Icon(Icons.view_compact),
          ),
        ),
        TextFormField(
          validator: (text) {
            Pattern pattern =
                r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(text))
              return 'Invalid password. Password must contain atleast 1 letter,\n 1 number and must be 6 characters long';
            else
              return null;
          },
          onSaved: (text) => _password = text,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Password',
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: IconButton(
                icon: _obscurePassword
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () => {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      })
                    }),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (_cpassword != _password) return 'Passwords do not match';
            return null;
          },
          onSaved: (text) => _cpassword = text,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
              labelText: 'Confirm password',
              hintText: 'Confirm Password',
              prefixIcon: Icon(Icons.vpn_key),
              suffixIcon: IconButton(
                  icon: _obscurePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () => {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        })
                      })),
        ),
      ]),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Sign up - Company'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Welcome',
                style: TextStyle(
                    color: Color(0xFF002626),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Please enter the required details:',
              style: TextStyle(
                color: Color(0xFF002626),
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  DetailsForm,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Card(
                      color: Colors.teal,
                      child: FlatButton(
                        onPressed: pageloading
                            ? null
                            : () async {
                                this.setState(() {
                                  pageloading = true;
                                });
                                final position = await Geolocator()
                                    .getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);
                                dynamic result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => G_Map(
                                        position.latitude, position.longitude),
                                  ),
                                );
                                this.setState(() {
                                  pageloading = false;
                                });
                                if (result != null) {
                                  setState(() {
                                    _location = result;
                                    locationset = true;
                                  });
                                }
                                // }
                              },
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Current Location',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          trailing: Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  locationset
                      ? Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                          child: Container(
                            color: Colors.grey[400],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 8.0, 15.0, 8.0),
                                  child: Text(
                                    "Your location has been set",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                IconButton(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _location = null;
                                        locationset = false;
                                      });
                                    })
                              ],
                            ),
                          ),
                        )
                      : SizedBox(height: 0.0),
                  SizedBox(height: 20.0),
                  ButtonTheme(
                    minWidth: 170.0,
                    child: RaisedButton(
                      color: Colors.teal,
                      onPressed: _submit,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
