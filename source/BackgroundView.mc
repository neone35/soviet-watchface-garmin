using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Application;
using Toybox.Time.Gregorian as Date;

class BackgroundView extends Ui.Drawable {

	hidden var bgcir_font, bgcir_info;

    var radius;
	var mark_length = 10;
	
    function initialize(params) {
        Drawable.initialize(params);
        radius = centerOfX - (10*centerOfX/120).toNumber();
        if (centerOfX==195) {
			mark_length = 20;
		}
    }

    function draw(dc) {	
		
    }
}
