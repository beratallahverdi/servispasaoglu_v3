import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/classes/user.dart';

// ignore: must_be_immutable
class UserDetails extends StatefulWidget {
  final User selectedUser;
  const UserDetails({
    Key? key,
    required this.selectedUser,
  }) : super(key: key);
  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  // The controller for the ListView
  final Map<String, TextEditingController> _textControllers = {};

  @override
  void initState() {
    super.initState();
    _textControllers['credit'] = TextEditingController(text: 'credit');
    _textControllers['credit']!.text =
        widget.selectedUser.store!.sellerCredit!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: InkWell(
              child: SizedBox(
                  height: 44.0,
                  width: 220.0, // fixed width and height
                  child: Image.asset("assets/images/pasaoglu-vertical.png"))),
          //Text("${S.of(context).ordersTitle}")
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Text("User", style: Theme.of(context).textTheme.titleLarge),
              const Divider(),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Name'),
                      subtitle: Text(
                          "${widget.selectedUser.firstName} ${widget.selectedUser.lastName}"),
                    ),
                    ListTile(
                      title: const Text('Email'),
                      subtitle: Text(widget.selectedUser.email!),
                    ),
                    ListTile(
                      title: const Text('Phone'),
                      subtitle: Text(widget.selectedUser.phoneNumber!),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Text("Store", style: Theme.of(context).textTheme.titleLarge),
              const Divider(),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Name'),
                      subtitle:
                          Text("${widget.selectedUser.store!.sellerName}"),
                    ),
                    ListTile(
                      title: const Text('Email'),
                      subtitle:
                          Text("${widget.selectedUser.store!.sellerEmail}"),
                    ),
                    ListTile(
                      title: const Text('Phone'),
                      subtitle:
                          Text("${widget.selectedUser.store!.sellerPhone}"),
                    ),
                    ListTile(
                      title: const Text('Credit'),
                      subtitle:
                          Text("${widget.selectedUser.store!.sellerCredit}"),
                    ),
                    ListTile(
                      title: const Text('Address'),
                      subtitle:
                          Text("${widget.selectedUser.store!.sellerAddress}"),
                    ),
                    ListTile(
                      title: const Text('City'),
                      subtitle: Text(
                          "${widget.selectedUser.store!.city} ${widget.selectedUser.store!.country}"),
                    ),
                  ],
                ),
              ),
              const Divider(),
              TextField(
                controller: _textControllers['credit'],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Credit',
                ),
              ),
              ElevatedButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Credit: ${widget.selectedUser.store!.sellerCredit} -> ${_textControllers['credit']!.text} Are you confirm?"),
                        action: SnackBarAction(
                            label: "OK",
                            onPressed: () {
                              try {
                                widget.selectedUser.store!.setSellerCredit(
                                    int.parse(
                                        _textControllers['credit']!.text));
                                widget.selectedUser.update().then((value) =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Updated"),
                                    )));
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Error"),
                                ));
                              }
                            }),
                      )),
                  child: const Text('Save'))
            ])));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
