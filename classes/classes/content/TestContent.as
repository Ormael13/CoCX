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
			
			outputText("\nsackDescript " + player.sackDescript());
			outputText("\ncockClit " + player.cockClit());
//			outputText("\nballs " + balls(0, 0));
			outputText("\nsheathDesc " + player.sheathDesc());
			outputText("\nchestDesc " + player.chestDesc());
			outputText("\nallChestDesc " + player.allChestDesc());
			outputText("\nsMultiCockDesc " + player.sMultiCockDesc());
			outputText("\nSMultiCockDesc " + player.SMultiCockDesc());
			outputText("\noMultiCockDesc " + player.oMultiCockDesc());
			outputText("\nOMultiCockDesc " + player.OMultiCockDesc());
			outputText("\ntongueDescript " + player.tongueDescript());
			outputText("\nballsDescriptLight false " + player.ballsDescriptLight(false));
			outputText("\nballsDescriptLight true " + player.ballsDescriptLight(true));
			outputText("\nballDescript " + player.ballDescript());
			outputText("\nballsDescript " + player.ballsDescript());
			outputText("\nsimpleBallsDescript " + player.simpleBallsDescript());
			outputText("\nassholeDescript " + player.assholeDescript());
			outputText("\nhipDescript " + player.hipDescript());
			outputText("\nassDescript " + player.assDescript());
			outputText("\nbuttDescript " + player.buttDescript());
			outputText("\nnippleDescript " + player.nippleDescript(0));
			outputText("\nhairDescript " + player.hairDescript());
			outputText("\nhairOrFur " + player.hairOrFur());
			outputText("\nclitDescript " + player.clitDescript());
			outputText("\nvaginaDescript " + player.vaginaDescript());
			outputText("\nallVaginaDescript " + player.allVaginaDescript());
			outputText("\nmultiCockDescriptLight " + player.multiCockDescriptLight());
			outputText("\ncockAdjective " + player.cockAdjective());
			outputText("\ncockDescript " + player.cockDescript(0));
			outputText("\nbiggestBreastSizeDescript " + biggestBreastSizeDescript());
			outputText("\nbreaseSize 5" + breastSize(5));
			outputText("\nbreastDescript " + player.breastDescript(0));
			outputText("\ncockHead " + player.cockHead());
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
			doNext(camp.returnToCampUseOneHour);
		}
		
	}

}