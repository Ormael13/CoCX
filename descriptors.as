import classes.Appearance;
import classes.CockTypesEnum;
import classes.internals.Utils;

public function sackDescript():String
{
	return Appearance.sackDescript(player);
}

public function cockClit(number:int = 0):String {
	if(player.hasCock() && number >= 0 && number < player.cockTotal()) return player.cockDescript(number);
	else return clitDescript();
}

public function chestDesc():String {
	return player.chestDesc();
}

public function tongueDescript():String {
	return Appearance.tongueDescription(player);
}
public function wingsDescript():String {
	return Appearance.wingsDescript(player);
}
public function tailDescript():String {
	return Appearance.tailDescript(player);
}
public function oneTailDescript():String {
	return Appearance.oneTailDescript(player);
}

public function ballsDescriptLight(forcedSize:Boolean = true):String {
	return Appearance.ballsDescription(forcedSize, true, player);
}

public function ballDescript():String {
	return Appearance.ballsDescription(false, false, player);
}

public function ballsDescript():String {
	return Appearance.ballsDescription(false, true, player, true);
}
public function simpleBallsDescript():String {
	return Appearance.ballsDescription(false, true, player);
}

public function assholeDescript():String {
	return Appearance.assholeDescript(player);
}
		
public function hipDescript():String {
	return Appearance.hipDescription(player);
}
public function assDescript():String {
	return buttDescript();
}
public function buttDescript():String {
	return Appearance.buttDescription(player);
}

public function nippleDescript(rowNum:Number):String {
	return Appearance.nippleDescription(player, rowNum);
}

public function hairDescript():String {
	return Appearance.hairDescription(player);
}

public function beardDescript():String {
	return Appearance.beardDescription(player);
}

public function hairOrFur():String {
	return Appearance.hairOrFur(player);
}

public function clitDescript():String {
	return Appearance.clitDescription(player);
}

//Vaginas + Descript
public function vaginaDescript(vaginaNum:Number = 0):String {
	return Appearance.vaginaDescript(player, vaginaNum);
}

//Allvagina descript
public function allVaginaDescript():String {
	if (player.vaginas.length == 1) return vaginaDescript(rand(player.vaginas.length - 1));
	if (player.vaginas.length > 1) return (vaginaDescript(rand(player.vaginas.length - 1)) + "s");
	
	CoC_Settings.error("ERROR: allVaginaDescript called with no vaginas.");
	return "ERROR: allVaginaDescript called with no vaginas.";
}

public function cockDescript(cockNum:int = 0):String 
{
	return player.cockDescript(cockNum);
}

public function allBreastsDescript():String {
	return Appearance.allBreastsDescript(player);
}
	
public function breastDescript(rowNum:Number):String
{
	return player.breastDescript(rowNum);
}

public function num2Text(number:int):String {
	return Utils.num2Text(number);
}

public function num2Text2(number:int):String {
	return Utils.num2Text2(number);
}

public function Num2Text(number:int):String {
	return Utils.Num2Text(number);
}

public function addComma(number:int):String {
	return Utils.addComma(number);
}

public function capitalizeFirstLetter(string:String):String {
	return Utils.capitalizeFirstLetter(string);
}
