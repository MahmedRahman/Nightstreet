import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:krzv2/web_serives/api_manger.dart';

PreferredSize DebugView() {
  return PreferredSize(
    preferredSize: Size.fromHeight(220),
    child: Scaffold(
      appBar: AppBar(
        title: Text("Debug"),
        actions: [
          IconButton(
            onPressed: () {
              ResponseModelList.clear();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Obx(
            () {
              return ListView(
                children: List.generate(
                  ResponseModelList.length,
                  (index) {
                    return Card(
                      color: ResponseModelList.elementAt(index).statusCode == 200
                          ? Colors.green.withOpacity(.1)
                          : Colors.red.withOpacity(.1),
                      child: ListTile(
                        leading: (ResponseModelList.elementAt(index).httpRequest == HTTPRequestEnum.GET)
                            ? Text(
                                "Get",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "Post",
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.copy_all),
                        ),
                        title: Text(
                          ResponseModelList.elementAt(index).url.toString(),
                          maxLines: 2,
                          style: TextStyle(),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
