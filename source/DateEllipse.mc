using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Application;
using Toybox.Time.Gregorian;
using Toybox.Test;

function addZero(number) {
    var numLength = number.format("%1d").length();
    //System.println( "Number is" +  number + "and has length of" + numLength);
    if (numLength<=1) {
        return "0"+number;
    } else {
        return number;
    }
}

class DateEllipse extends Ui.Drawable {

    var heightOfEllipse = 10;
    var radiusOfEllipse = 25;
    var xyOfEllipse = 50;
    var dateString = "00/00";
	
    function initialize(params) {
        Drawable.initialize(params);
    }

    function draw(dc) {
        //draw filled ellipse to hold date
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.fillEllipse(xyOfEllipse, xyOfEllipse, radiusOfEllipse, heightOfEllipse);
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        dateString = Lang.format(
            "$1$/$2$", 
            [today.month.format("%02d"),today.day.format("%02d")]
            );
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(xyOfEllipse, xyOfEllipse-heightOfEllipse, made_evolve16_font, dateString, Graphics.TEXT_JUSTIFY_CENTER);

    	// dc.setPenWidth(4);
		// dc.setColor(gsecondary_color, Graphics.COLOR_TRANSPARENT);
    	// for(var i = 0; i < 6; i += 1) {
		//     var rad = (i.toFloat()/(6.0))*2*Math.PI;
	    // 	dc.drawLine(
		// 	    convertCoorX(rad, radius - mark_length/2), 
		// 	    convertCoorY(rad, radius - mark_length/2), 
		// 	    convertCoorX(rad, radius + mark_length/2), 
		// 	    convertCoorY(rad, radius + mark_length/2)
		//     );
		// }
    }
}