import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_response_model.dart';

class NetworkErrorPage extends GetView {
  ResponseModel responseModel;

  NetworkErrorPage(this.responseModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error Page"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text("statusCode"),
              subtitle: Text(responseModel.statusCode.toString()),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("URL"),
              subtitle: Text(responseModel.url.toString()),
              trailing: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(
                      text: responseModel.url.toString(),
                    ),
                  );
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Query"),
              subtitle: Text(responseModel.query.toString()),
              trailing: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(
                      text: responseModel.query.toString(),
                    ),
                  );
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Respons"),
              subtitle: Text(responseModel.data.toString()),
              trailing: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
