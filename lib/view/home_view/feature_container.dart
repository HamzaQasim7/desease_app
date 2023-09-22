import 'package:flutter/material.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/constants.dart';

class FeatureContainer extends StatelessWidget {
  const FeatureContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return SizedBox(
      height: height * 0.25,
      width: width,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              width: width * 0.95,
              height: height * 0.22,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Expanded(
                      flex: 3,
                      child: Image(
                        width: 100,
                        height: 100,
                        image: AssetImage('assets/heart-rate.png'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 7,
                      child: Column(children: [
                        Text('Working on revolutionizing healthcare',style: kH0Text,),
                        SizedBox(height: 8,),
                        FeatureContent()
                      ],),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FeatureContent extends StatefulWidget{
  const FeatureContent({super.key});

  @override
  _FeatureContentState createState() => _FeatureContentState();
}

class _FeatureContentState extends State<FeatureContent> {
  List<String> str = [
    "Something regarding to the future",
    "3 perspectives",];
  @override
  Widget build(BuildContext context) {
    return  Container(
          child: Column(
            children: str.map((strone){
              return Row(
                  children:[
                    Text("\u2022", style: kH4Text), //bullet text
                    SizedBox(width: 10,), //space between bullet and text
                    Expanded(
                      child:Text(strone, style: kH4Text),), //text

                  ]
              );
            }).toList(),
          ),
        );
  }
}
