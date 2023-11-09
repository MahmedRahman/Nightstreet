import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/web_serives/api_manger.dart';

class ResponseTrakePage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Response Trace"),
        actions: [
          IconButton(
            onPressed: () {
              ResponseModelList.clear();
            },
            icon: Icon(Icons.clean_hands),
          )
        ],
      ),
      body: 
      
      
      Obx(() {
        return
        
         ListView(
          children: List.generate(ResponseModelList.length, (index) {
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
          }),
        );
      }),
    
    
    );
  }
}
