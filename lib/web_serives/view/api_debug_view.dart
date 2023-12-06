import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:krzv2/init_bindings.dart';
import 'package:krzv2/web_serives/api_manger.dart';
import 'package:flutter/services.dart';

PreferredSize DebugView() {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Scaffold(
      // drawer: Drawer(
      //   child:

      //   SafeArea(
      //     child: Container(
      //       child: Obx(
      //         () {
      //           return ListView(
      //             children: List.generate(
      //               ResponseModelList.length,
      //               (index) {
      //                 return Card(
      //                   color: ResponseModelList.elementAt(index).statusCode == 200
      //                       ? Colors.green.withOpacity(.1)
      //                       : Colors.red.withOpacity(.1),
      //                   child: ListTile(
      //                     leading: (ResponseModelList.elementAt(index).httpRequest == HTTPRequestEnum.GET)
      //                         ? Text(
      //                             "Get",
      //                             style: TextStyle(
      //                               color: Colors.green,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           )
      //                         : Text(
      //                             "Post",
      //                             style: TextStyle(
      //                               color: Colors.yellow,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                     trailing: IconButton(
      //                       onPressed: () {
      //                         Clipboard.setData(ClipboardData(text: ResponseModelList.elementAt(index).url.toString()));
      //                       },
      //                       icon: Icon(Icons.copy_all),
      //                     ),
      //                     title: Text(
      //                       ResponseModelList.elementAt(index).url.toString(),
      //                       maxLines: 2,
      //                       style: TextStyle(),
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ),

      // ),
      // appBar: AppBar(),
      appBar: AppBar(
        title: Text("Debug"),
        actions: [
          IconButton(
            onPressed: () {
              ResponseModelList.clear();
            },
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              ApiConfig.baseUrl = "https://app-krz.tasksa.dev/api";
              InitBindings();
            },
            icon: Text("Dev"),
          ),
          IconButton(
            onPressed: () {
              ApiConfig.baseUrl = "https://api-v2.krz.sa/api";
              InitBindings();
            },
            icon: Text("Production"),
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
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: ResponseModelList.elementAt(index).url.toString()));
                          },
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
