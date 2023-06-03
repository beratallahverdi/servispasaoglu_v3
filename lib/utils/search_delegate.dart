import 'package:flutter/material.dart';
import 'package:servispasaoglu_v3/api/order.dart';
import 'package:servispasaoglu_v3/classes/logged_user.dart';
import 'package:servispasaoglu_v3/classes/order.dart';
import 'package:servispasaoglu_v3/classes/orders_response.dart';
import 'package:servispasaoglu_v3/classes/user.dart';
import 'package:servispasaoglu_v3/screens/Order/order_page.dart';
import 'package:servispasaoglu_v3/screens/Orders/orders_page_card.dart';
import 'package:servispasaoglu_v3/screens/Users/user_details.dart';

class SearchOrder extends SearchDelegate {
  ServisPasaogluUser user;
  List<Order> suggestionList = <Order>[];
  late Order selectedOrder;
  SearchOrder({required this.user});

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return OrderCard(
            suggestionList[index],
            user,
            onTap: () {
              selectedOrder = suggestionList[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderPage(
                    user,
                    orderId: selectedOrder.orderId,
                  ),
                ),
              );
            },
            onAssociate: () {},
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionList.clear();
    return (query.length > 1)
        ? FutureBuilder(
            future: OrdersAPI.getWithKeyword(keyword: query, limit: 50),
            builder: (context, snapshot) {
              suggestionList.clear();
              if (snapshot.hasData) {
                OrdersResponse response = snapshot.data as OrdersResponse;
                suggestionList.addAll(response.data!);
                return ListView.builder(
                  itemCount: response.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(response.data!.elementAt(index).getOrderTitle()),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderPage(
                              user,
                              orderId: response.data!.elementAt(index).orderId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
        : Container();
  }
}

class SearchUsers extends SearchDelegate {
  List<User> suggestionList = <User>[];
  List<User> newSuggestionList = <User>[];
  late User selectedOrder;
  SearchUsers({required this.suggestionList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: newSuggestionList.length,
      itemBuilder: (context, index) {
        return newSuggestionList[index].card(context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    newSuggestionList.clear();
    for (User element in suggestionList) {
      if (element.toJson().toLowerCase().contains(query.toLowerCase())) {
        newSuggestionList.add(element);
      }
    }
    return ListView.builder(
      itemCount: newSuggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
              "${newSuggestionList.elementAt(index).store!.city} - ${newSuggestionList.elementAt(index).firstName} ${newSuggestionList.elementAt(index).lastName}"),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserDetails(
                    selectedUser: newSuggestionList.elementAt(index)),
              ),
            );
          },
        );
      },
    );
  }
}
