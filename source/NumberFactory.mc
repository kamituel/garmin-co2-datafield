using Toybox.Graphics;
using Toybox.WatchUi;

class NumberFactory extends WatchUi.PickerFactory
{
    hidden var mStart;
    hidden var mStop;
    hidden var mIncrement;
    hidden var mFormatString;
    hidden var mFont;

    function getIndex (value)
    {
        var index = (value / mIncrement) - mStart;
        return index;
    }

    function initialize (start, stop, increment, options)
    {
        PickerFactory.initialize();

        mStart = start;
        mStop = stop;
        mIncrement = increment;
        mFont = Graphics.FONT_NUMBER_HOT;
        mFormatString = "%d";
    }

    function getDrawable (index, selected)
    {
        return new WatchUi.Text({
            :text => getValue(index).format(mFormatString),
            :color => Graphics.COLOR_WHITE,
            :font => mFont,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    function getValue (index)
    {
        return mStart + (index * mIncrement);
    }

    function getSize ()
    {
        return ( mStop - mStart ) / mIncrement + 1;
    }

}
