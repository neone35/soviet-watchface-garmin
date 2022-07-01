using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Application;
using Toybox.Time.Gregorian;

class MainClock extends Ui.Drawable {

    var mainBg = 0x3F3A36;
    var digitBg = 0x000000;

    var mainBgWidth = 180;
    var mainBgHeight = 57;
    var numberOfDigits = 4;
    var digitBgWidth = 25;
    var digitBgHeight = 45;

    var tempForDigitX = 0;
	
    function initialize(params) {
        Drawable.initialize(params);
    }

    function draw(dc) {
        //draw background for a clock
        dc.setColor(mainBg, mainBg);
        var startXOfMainBg = centerOfX - mainBgWidth/2;
        var startYOfMainBg = centerOfY - mainBgHeight/2;
        dc.fillRectangle(startXOfMainBg, startYOfMainBg, mainBgWidth, mainBgHeight);
        //draw background for digits
        dc.setColor(digitBg, digitBg);
        tempForDigitX = startXOfMainBg+6;
        dc.fillRectangle(tempForDigitX, startYOfMainBg+6, digitBgWidth, digitBgHeight);
        for(var i = 0; i < numberOfDigits-1; i++){
            tempForDigitX = tempForDigitX+digitBgWidth+22;
			dc.fillRectangle(tempForDigitX, startYOfMainBg+6, digitBgWidth, digitBgHeight);
		}
        tempForDigitX = 0;

        // Get the current time and format it correctly
        // var timeFormat = "$1$:$2$";
        var timeFormat = "$1$$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        var mins = clockTime.min;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        }
        var timeString = Lang.format(timeFormat, [hours, mins.format("%02d")]);

        // put clock into digit backgrounds 
        //dc.clear();
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        tempForDigitX = startXOfMainBg+6;
		dc.drawText(tempForDigitX + (digitBgWidth/2), startYOfMainBg+6, 
					made_evolve48_font, 
					timeString.substring(0, 1), 
					Graphics.TEXT_JUSTIFY_CENTER);
        for(var i = 1; i < numberOfDigits; i++){
            tempForDigitX = tempForDigitX+digitBgWidth+22+(digitBgWidth/2);
			dc.drawText(tempForDigitX, startYOfMainBg+6, 
					made_evolve48_font, 
					timeString.substring(i, i+1), 
					Graphics.TEXT_JUSTIFY_CENTER);
            tempForDigitX-=(digitBgWidth/2);
		}
        tempForDigitX = 0;
    }
}