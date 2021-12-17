import 'package:csia/consts.dart';

import 'package:flutter/material.dart';
import 'package:csia/VidPlayer/VideoPlayerV3.dart';
import 'package:csia/VidPlayer/Services/ApiServices.dart';
import 'package:csia/utilities/ErrorPage.dart';

import 'YoutubeResponse.dart';
import 'package:csia/consts.dart';


class VidPlayer extends StatefulWidget {
  static String vidPlayerID = 'VidPlayerID';
  @override
  _VidPlayerState createState() => _VidPlayerState();
}

class _VidPlayerState extends State<VidPlayer> {
  Color color1 = myTheme.accentColor;
  Color color2 = myTheme.accentColor;
  Color color3 = myTheme.accentColor;
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
      searchBody = CircularProgressIndicator(color: myTheme.accentColor,);
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
      backgroundColor: myTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: myTheme.accentColor,
        title: Text('Search for videos', style: kTextStyle,),
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
                   decoration : kInputDecoration.copyWith(hintText: 'Your search term'),

                    controller: _controller,
                    onChanged: (value){
                      controllerValue = value;
                    },
                  ),
                ),

                SizedBox(width: 20,),
                TextButton(onPressed: (){
                  print('my method');


                  print(maxResult.toString()+controllerValue);
                  createResultPage();

                }, child: Text('Search', style: kTextStyle,),
                    style: kButtonStyle,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NumberButton(
                      '10',
                          (){
                        setState(() {
                          maxResult='10';
                          color1 = myTheme.hoverColor;
                          color2 = myTheme.accentColor;
                          color3 = myTheme.accentColor;
                        });
                        },
                      color1),
                ),//custom Flutter Widget to save code
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NumberButton('20', (){
                    setState(() {
      maxResult='20';
      color1 = myTheme.accentColor;
      color2 = myTheme.hoverColor;
      color3 = myTheme.accentColor;
                    });
                    }, color2),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NumberButton('30',(){
                    maxResult='30';
                    setState(() {
                      color1 = myTheme.accentColor;
                      color2 = myTheme.accentColor;
                      color3 = myTheme.hoverColor;
                    });
                    }, color3),
                ),
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: TextButton(//wrap in a button so that you can click anywhere and get the video
          style: kButtonStyle,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerV3(vidID: vidID, title: title)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: NetworkImage(thumbnailURL),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(10) , child: Text(title, style: kTextStyle,)),
                    Text(channel, style: kTextStyle.copyWith(fontSize: 12),),
                    Text(description, style: kTextStyle.copyWith(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
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
      child: Text(widget.number, style: kTextStyle),
      style: kButtonStyle.copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(widget.color),
      ),
    );
  }
}

