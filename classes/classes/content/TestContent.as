package classes.content 
{
	import classes.BaseContent;
	/**
	 * ...
	 * @author Gedan
	 */
	public class TestContent extends BaseContent
	{
		
		public function TestContent() 
		{
			
		}
		
		public function cheatSheet():void
		{
			clearOutput();
			
			outputText("<b>Parser Cheet Sheet:</b>\n\n");
			outputText("Descriptor (descriptor.as) Functions:\n");
			
			outputText("\nsackDescript " + sackDescript());
			outputText("\ncockClit " + cockClit);
			outputText("\nballs " + balls(0, 0));
			outputText("\nsheathDesc " + sheathDesc());
			outputText("\nchestDesc " + chestDesc());
			outputText("\nallChestDesc " + allChestDesc());
			outputText("\nsMultiCockDesc " + sMultiCockDesc());
			outputText("\nSMultiCockDesc " + SMultiCockDesc());
			outputText("\noMultiCockDesc " + oMultiCockDesc());
			outputText("\nOMultiCockDesc " + OMultiCockDesc());
			outputText("\ntongueDescript " + tongueDescript());
			outputText("\nballsDescriptLight false " + ballsDescriptLight(false));
			outputText("\nballsDescriptLight true " + ballsDescriptLight(true));
			outputText("\nballDescript " + ballDescript());
			outputText("\nballsDescript " + ballsDescript());
			outputText("\nsimpleBallsDescript " + simpleBallsDescript());
			outputText("\nassholeDescript " + assholeDescript());
			outputText("\nhipDescript " + hipDescript());
			outputText("\nassDescript " + assDescript());
			outputText("\nbuttDescript " + buttDescript());
			outputText("\nnippleDescript " + nippleDescript(0));
			outputText("\nhairDescript " + hairDescript());
			outputText("\nhairOrFur " + hairOrFur());
			outputText("\nclitDescript " + clitDescript());
			outputText("\nvaginaDescript " + vaginaDescript());
			outputText("\nallVaginaDescript " + allVaginaDescript());
			outputText("\nmultiCockDescriptLight " + multiCockDescriptLight());
			outputText("\ncockAdjective " + cockAdjective());
			outputText("\ncockDescript " + cockDescript(0));
			outputText("\nbiggestBreastSizeDescript " + biggestBreastSizeDescript());
			outputText("\nbreaseSize 5" + breastSize(5));
			outputText("\nbreastDescript " + breastDescript(0));
			outputText("\ncockHead " + cockHead(0));
			outputText("\nbreastCup 5 " + breastCup(5));
			
			outputText("\n\nParser Tags (Single)L\n");
			outputText("\naagility [agility]");
			outputText("\narmor [armor]");
			outputText("\narmorname [armorname]");
			outputText("\nass [ass]");
			outputText("\nasshole [asshole]");
			outputText("\nballs [balls]");
			outputText("\nboyfriend [boyfriend]");
			outputText("\nbutt [butt]");
			outputText("\nbutthole [butthole]");
			outputText("\nchest [chest]");
			outputText("\nclit [clit]");
			outputText("\ncock [cock]");
			outputText("\ncockhead [cockhead]");
			outputText("\ncocks [cocks]");
			outputText("\ncunt [cunt]");
			outputText("\neachcock [eachCock]");
			outputText("\nevade [evade]");
			outputText("\nface [face]");
			outputText("\nfeet [feet]");
			outputText("\nfoot [foot]");
			outputText("\nfullchest [fullchest]");
			outputText("\nhair [hair]");
			outputText("\nhairorfur [hairorfur]");
			outputText("\nhe [he]");
			outputText("\nhim [him]");
			outputText("\nhips [hips]");
			outputText("\nhis [his]");
			outputText("\nleg [leg]");
			outputText("\nlegs [legs]");
			outputText("\nman [man]");
			outputText("\nmaster [master]");
			outputText("\nmisdirection [misdirection]");
			outputText("\nmulticockdescriptlight [multicockdescriptlight]");
			outputText("\nname [name]");
			outputText("\nnipple [nipple]");
			outputText("\nnipples [nipples]");
			outputText("\nonecock [onecock]");
			outputText("\npg [pg]");
			outputText("\npussy [pussy]");
			outputText("\nsack [sack]");
			outputText("\nsheath [sheath]");
			outputText("\nskin [skin]");
			outputText("\nskinfurscales [skinfurscales]");
			outputText("\ntongue [tongue]");
			outputText("\nvag [vag]");
			outputText("\nvagina [vagina]");
			outputText("\nvagorass [vagorass]");
			outputText("\nweapon [weapon]");
			outputText("\nweaponname [weaponname]");
			
			trace("Spammed!");
			doNext(13);
		}
		
	}

}