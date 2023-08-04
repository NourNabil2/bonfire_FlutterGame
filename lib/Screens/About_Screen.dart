

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/constant.dart';


class About_screen extends StatefulWidget {
  const About_screen({Key? key}) : super(key: key);

  @override
  State<About_screen> createState() => _About_screen();
}

class _About_screen extends State<About_screen> {

  Future<void> _launchURL(String scheme,String url,String path,String q) async {
    final Uri uri = Uri(scheme: scheme, host: url,path: path ,query:  q );
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }
  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(left: 200),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.7)),
          width: 400,
          height: double.infinity,
          child:  Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('About me \n \n'
                        'My name is Nour Nabil, I am a Flutter developer.\n'
                        'This individual work is a challenge for me to make a small game using the flutter using package Flame and Bonfire.\nThe game was made in at least a month. I faced a lot of challenges from design, coding and problem solving, but the most important thing is that I enjoyed sharing this small work.\nYou can take a quick look at source Code in Github\n,Thank you for downloading and I hope you enjoyed,\n \n feel free to contact me:',
                      style: style1,
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        Expanded(child: MaterialButton(onPressed: () => _launchURL('https','www.linkedin.com','in/nour-nabil-615330217/','') ,
                            child: Image.asset('assets/images/image_Interface/linkedin_pixel.png',width:50))),
                        Expanded(child: MaterialButton(onPressed: () => _launchURL('https',"www.github.com",'NourNabil2',''),
                            child: Image.asset('assets/images/image_Interface/GitHub_pixel.png',width:50))),
                        Expanded(child: MaterialButton(onPressed: () => _launchURL('mailto',""
                            ,'nour60g@gmail.com', 'subject=Game &'
                                'body=Hello Nour,'),
                            child: Image.asset('assets/images/image_Interface/Gmail.png',width:50))),

                      ],
                    ),

                  ],
                ),
              ]
            ),
          ),
        ),
      );
  }
}



