import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterbeginner/global/constant/api_const.dart';
import 'package:flutterbeginner/global/constant/string_const.dart';
import 'package:flutterbeginner/global/utils/widget_helper.dart';
import 'package:http/http.dart' as http;

class LVPagination extends StatefulWidget {
  @override
  _LVPaginationState createState() => _LVPaginationState();
}

class _LVPaginationState extends State<LVPagination> {
  List dataResult = new List();
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  BuildContext ctx;

  @override
  void initState() {
    this.callApi();
    super.initState();
    _scrollController.addListener(() {
      debugPrint(
          "pixels : ${_scrollController.position.pixels}  \n maxScrollExtent : ${_scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 8000)) {
        callApi();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBarWithBackBtn(context, StringConst.PAGINATION_TITLE),
        body: Builder(
          builder: (context) => _createUi(context),
        ));
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _createUi(BuildContext context) {
    ctx = context;
    return Container(
      child: ListView.builder(
        //+1 for progressbar
        itemCount: dataResult.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == dataResult.length) {
            return _buildProgressIndicator();
          } else {
            return new ListTile(
//            contentPadding: EdgeInsets.all(0),
              title: getTxt(dataResult[index]['Country'], null),
              onTap: () {
                showSnackBar(context, dataResult[index]['Country']);
                print(dataResult[index]);
              },
            );
          }
        },
        controller: _scrollController,
      ),
    );
  }

  Future<String> callApi() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var response = await http
          .get(ApiConst.CORONA_URL, headers: {"Accept": "application/json"});
      setState(() {
        isLoading = false;
        if (response.statusCode == 200) {
          debugPrint(response.body);
          var converData = jsonDecode(response.body);
          dataResult.addAll(converData["Countries"]);
        } else {
          throw Exception('Unable to fetch products from the REST API');
        }
      });
    }
    return "Success";
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
