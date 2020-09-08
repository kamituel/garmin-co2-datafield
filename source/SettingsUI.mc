using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;
using Toybox.WatchUi;
using Settings;

const FACTORY_COUNT_24_HOUR = 3;
const FACTORY_COUNT_12_HOUR = 4;
const MINUTE_FORMAT = "%02d";

class CarEmissionsPicker extends WatchUi.Picker
{
  function initialize ()
  {
    var title = new WatchUi.Text({
      :text => Rez.Strings.EmissionsPickerTitle,
      :locX => WatchUi.LAYOUT_HALIGN_CENTER,
      :locY => WatchUi.LAYOUT_VALIGN_BOTTOM,
      :color => Graphics.COLOR_WHITE
    });

    var factories = new [3];
    factories[0] = new NumberFactory(0, 9, 1, {});
    factories[1] = new NumberFactory(0, 9, 1, {});
    factories[2] = new NumberFactory(0, 9, 1, {});

    var defaults = new [3];

    var value = Application.getApp().getProperty(Settings.CAR_EMISSIONS);

    if (value == null) {
      value = 180;
    }

    defaults[0] = Math.floor(value / 100);
    defaults[1] = Math.floor((value - (defaults[0] * 100)) / 10);
    defaults[2] = Math.floor(value - (defaults[0] * 100) - (defaults[1] * 10));

    Picker.initialize({
      :title => title,
      :pattern => factories,
      :defaults => defaults
    });
  }
}

class CarEmissionsPickerDelegate extends WatchUi.PickerDelegate
{
  function initialize ()
  {
    PickerDelegate.initialize();
  }

  function onCancel ()
  {
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
  }

  function onAccept (values)
  {
    var value = values[0] * 100 + values[1] * 10 + values[2];
    Application.getApp().setProperty(Settings.CAR_EMISSIONS, value);
    WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
  }
}

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate
{
    function initialize ()
    {
      Menu2InputDelegate.initialize();
    }

    function onSelect (item)
    {
      WatchUi.pushView(
        new CarEmissionsPicker(),
        new CarEmissionsPickerDelegate(),
        WatchUi.SLIDE_IMMEDIATE
      );
    }
}

function getSettingsView2 ()
{
  var menu = new WatchUi.Menu2({:title=>"CO2 Savings"});

  menu.addItem(
      new WatchUi.MenuItem(
        Rez.Strings.SettingsCarEmissionsMenuItemTitle,
        Rez.Strings.SettingsCarEmissionsMenuItemSubtitle,
        Settings.CAR_EMISSIONS,
        {}
      )
  );

  return [menu, new SettingsMenuDelegate()];
}
