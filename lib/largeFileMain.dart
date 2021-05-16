import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'; //파일입출력은 돕는 키지

class LargeFileMain extends StatefulWidget {
  const LargeFileMain({Key key}) : super(key: key);

  @override
  _LargeFileMainState createState() => _LargeFileMainState();
}

class _LargeFileMainState extends State<LargeFileMain> {
  final imgUrl ='https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
                '?auto=compress';
  bool downloading =false ; //현재 내려받는중인지 확인하는변수
  var progressString = "" ; //현재 얼마나 내려받았는지 표시하는 변수
  var file;
  @override
  Widget build(BuildContext context) {

    print('_LargeFileMainState에옴');

    return Scaffold(
      appBar: AppBar(
        title: Text('Large FileExample',)
      ),

      body: Center(
        child:
        Container(
            height: 120.0,
            width: 200.0,
            child: Card(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Downloading File : $progressString',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
          ),
          ),
      ) ,
    );
  }

  Future<void> downloadFile() async{
    Dio dio =  Dio();
    try{
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(imgUrl, '${dir.path}/myimage.jpg', //rec는 지그까지 내려받은 데이터
          onReceiveProgress: (rec, total){
            print('Rec : $rec , Total : $total');
            file = '${dir.path}/myimage.jpg';
            setState(() {
              downloading = true;
              progressString = ((rec/total)*100).toStringAsFixed(0) + '%';
            });
          });
    }catch(e){
      print(e);
    }

    setState(() {
     downloading = false;
     progressString = 'Completed';
    });

    print('Download completed');
  }

}
