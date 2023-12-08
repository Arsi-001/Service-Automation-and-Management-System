import 'package:flutter/material.dart';


class ResponsiveLayout extends StatelessWidget {
  
  final Widget Mobile ;
  final Widget Desktop;
  final Widget Tablet;
   
   ResponsiveLayout({required this.Mobile , required this.Desktop, required this.Tablet});

  @override
  Widget build(BuildContext context) {
    
        
    
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if(constraints.maxWidth <= 630 )
        {
          return Mobile;
        }
        else if(constraints.maxWidth <= 910 )
      {
           return Tablet;
      }
      else 
      {
        return Desktop;
      }
      },
    );
  }
}