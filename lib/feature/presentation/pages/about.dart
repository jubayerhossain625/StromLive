import 'package:flutter/material.dart';
import 'package:stromlive/feature/presentation/widgets/text_widget.dart';
import 'package:stromlive/feature/utlis.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        title: const TextWidget(title: "About Us",size: 20,weight: FontWeight.w600,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kScaffoldBackgroundColor,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios,color: Colors.black,size: 30,))

      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children:  [
           const Padding(
             padding: EdgeInsets.all(10.0),
             child: TextLtdWidget(
                  title: sunAbout,line: 10,
                ),
           ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/stromlive.png')
                    )
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: TextLtdWidget(
                title: weatherAbout,line: 10,
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(10.0),
              child: TextLtdWidget(
                title: overall,line: 10,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
