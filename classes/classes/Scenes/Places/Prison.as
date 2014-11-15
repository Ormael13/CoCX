//Prisoner Mod WIP
package classes.Scenes.Places 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.*;
	
	import coc.view.MainView;
	
	public class Prison extends BaseContent
	{
		
		public function Prison() 
		{
		}
		
		public function prisonRoom():void {
			if(kGAMECLASS.timeQ > 0)
			{
				/*if(!kGAMECLASS.campQ)
				{
					outputText("More time passes...\n", true);
					goNext(kGAMECLASS.timeQ, false);
					return;
				}*/
				if(model.time.hours < 6 || model.time.hours > 20)
				{
					eventParser(41);
					return;
				}
				eventParser(11);
				return;
			}
			outputText("", true);
			//if(prisonRoomEvents())
			//{
			//	return;
			//}
			mainView.showMenuButton( MainView.MENU_NEW_MAIN );
			mainView.showMenuButton( MainView.MENU_DATA );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
			if (player.lust >= 30) {
				if (player.lust >= 100) {
					outputText("\n\n<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>", false);
					removeButton(0);
					removeButton(4);
				}
				addButton(8, "Masturbate", eventParser, 10);
				if (((player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.findStatusAffect(StatusAffects.Exgartuan) >= 0 && player.statusAffectv2(StatusAffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(8, "Meditate", eventParser, 10);
			}
			//Show wait/rest/sleep depending on conditions.
			addButton(9, "Wait", eventParser, 40);
			if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", eventParser, 11);
			if (model.time.hours >= 21 || model.time.hours < 6) addButton(9, "Sleep", eventParser, 41);
			hideUpDown();
			menu();
			addButton(0, "Train", eventParser, 9999);
			addButton(1, "Study", eventParser, 9999);
			addButton(2, "Inventory", eventParser, 1000);
			addButton(3, "Restraints", eventParser, 9999);
			addButton(4, "Escape", eventParser, 9999);
			addButton(5, "Clean", eventParser, 9999);
			addButton(8, "Masturbate", eventParser, 10);
			addButton(9, "Escape", eventParser, 9999);
			//prisonRoomText(/Volumes/Disk Image/CoC_Prison/startUp.as);
			//prisonRestraintText();
			//prisonRoomChoices(_loc_2, _loc_3);
			//choices(_loc_3[1], _loc_2[1], _loc_3[2], _loc_2[2], _loc_3[3], _loc_2[3], _loc_3[4], _loc_2[4], _loc_3[5], _loc_2[5], _loc_3[6], _loc_2[6], _loc_3[7], _loc_2[7], _loc_3[8], _loc_2[8], _loc_3[9], _loc_2[9], _loc_3[10], _loc_2[10]);

		}
	}

}