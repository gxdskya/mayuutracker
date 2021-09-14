

import 'package:flutter/material.dart';
import 'package:csia/VidPlayer/VideoPlayerV3.dart';
import 'package:csia/VidPlayer/Services/ApiServices.dart';
import 'package:csia/utilities/ErrorPage.dart';

import 'YoutubeResponse.dart';
class VidPlayer extends StatefulWidget {
  static String vidPlayerID = 'VidPlayerID';
  @override
  _VidPlayerState createState() => _VidPlayerState();
}

class _VidPlayerState extends State<VidPlayer> {
  Color color1 = Colors.blue;
  Color color2 = Colors.white;
  Color color3 = Colors.white;
  String maxResult = '10';//chosen by user
  TextEditingController _controller;//gets value from the textfield, clears on search
  String _yTubeApiKey = 'AIzaSyCStIqRn98hE33EiOn1ytcVpod5s8kDWXw';//api key, private so cannot be accessed elsewhere
  List<Item> vidResults;
  List<Widget> myVideoList =[];
  ApiService myApiService = ApiService();
  Widget searchBody = Container();
  void generateBody(List list){
  }
  String controllerValue;


  void loadNextPage() async {

  }
  void createResultPage() async{//method to output widgets from a list
    setState(() {
      searchBody = CircularProgressIndicator();
      myVideoList = [];
    });
    vidResults = await myApiService.getYoutubeData(maxResult, controllerValue);
    print(vidResults.toString());
    try{

      String title;
      String thumbnailURL;
      String channel;
      String description;
      String vidID;

      for(Item item in vidResults) {
        title = item.snippet.title;

        thumbnailURL = item.snippet.thumbnails.medium.url;
        channel = item.snippet.channelTitle;
        description = item.snippet.description;
        vidID = item.id.videoId;
        print(thumbnailURL);
        ApiResult myApiResult = ApiResult(title: title, channel: channel, description: description,thumbnailURL: thumbnailURL,vidID: vidID,);
        myVideoList.add(myApiResult);
        setState(() {
          searchBody = Expanded(
            child: ListView(
              children: myVideoList,
            ),
          );
        });
      }


      setState(() {
        Widget loadWidget = TextButton(child: Text('Load more?'),onPressed: () async{
           //load more pages TODO: Finish the load next page widget
        },);
        myVideoList.add(loadWidget);
      });


    }
    catch(Exception) {
      print('cannot connect/no result');
      searchBody = ErrorPage();
    }
  }

  @override
  void initState(){
    super.initState();
    
    //initState
  }
  void dispose(){
    super.dispose();
    _controller.dispose();//ensures that controller is disposed when we leave this page
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for videos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(

                    controller: _controller,
                    onChanged: (value){
                      controllerValue = value;
                    },
                  ),
                ),

                TextButton(onPressed: (){
                  print('my method');


                  print(maxResult.toString()+controllerValue);
                  createResultPage();

                }, child: Text('Search')),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NumberButton(
                    '10',
                        (){
                      setState(() {
                        maxResult='10';
                        color1 = Colors.blue;
                        color2 = Colors.white;
                        color3 = Colors.white;
                      });
                      },
                    color1),//custom Flutter Widget to save code
                NumberButton('20', (){
                  setState(() {
      maxResult='20';
      color1 = Colors.white;
      color2 = Colors.blue;
      color3 = Colors.white;
                  });
                  }, color2),
                NumberButton('30',(){
                  maxResult='30';
                  setState(() {
                    color1 = Colors.white;
                    color2 = Colors.white;
                    color3 = Colors.blue;
                  });
                  }, color3),
              ],
            ),

             SizedBox(
               height: 30,
             ),
             searchBody,
          ],
        ),
      ),
    );
  }
}

class ApiResult extends StatelessWidget {//custom widget
  final String title;//final variables
  final String thumbnailURL;
  final String channel;
  final String description;
  final String vidID;
  ApiResult({this.title, this.thumbnailURL, this.channel, this.description, this.vidID});//constructor
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(//wrap in a button so that you can click anywhere and get the video
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerV3(vidID: vidID, title: title)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image(
                image: NetworkImage(thumbnailURL),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title),
                  Text(channel),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberButton extends StatefulWidget {//custom widget
  final String number;
  final Color color;
  final Function onPressed;
  NumberButton(this.number, this.onPressed, this.color);

  @override
  _NumberButtonState createState() => _NumberButtonState();
}

class _NumberButtonState extends State<NumberButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Text(widget.number),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(widget.color),
      ),
    );
  }
}

