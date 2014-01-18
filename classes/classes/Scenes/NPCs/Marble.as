package classes.Scenes.NPCs
{
	import classes.Monster;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Marble extends Monster
	{
		private function marbleSpecialAttackOne():void {
			//Special1: Heavy overhead swing, high chance of being avoided with evasion, does heavy damage if it hits.
			var damage:Number = 0;
			//Blind dodge change
			if(hasStatusAffect("Blind") >= 0) {
				outputText("Marble unwisely tries to make a massive swing while blinded, which you are easily able to avoid.", false);
				combatRoundOver();
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 60) {
				outputText("You manage to roll out of the way of a massive overhand swing.", false);
				combatRoundOver();
				return;
			}
			//Determine if evaded
			if(player.hasPerk("Evade") >= 0 && rand(100) < 60) {
				outputText("You easily sidestep as Marble tries to deliver a huge overhand blow.", false);
				combatRoundOver();
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str + 20 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				outputText("You somehow manage to deflect and block Marble's massive overhead swing.", false);
			}
			if(damage > 0) damage = player.takeDamage(damage);
			outputText("You are struck by a two-handed overhead swing from the enraged cow-girl.  (" + damage + " damage).", false);
			statScreenRefresh();
			combatRoundOver();
		}
		private function marbleSpecialAttackTwo():void {
			//Special2: Wide sweep; very high hit chance, does low damage.
			var damage:Number = 0;
			//Blind dodge change
			if(hasStatusAffect("Blind") >= 0) {
				outputText("Marble makes a wide sweeping attack with her hammer, which is difficult to avoid even from a blinded opponent.\n", false);
			}
			//Determine if evaded
			if(player.hasPerk("Evade") >= 0 && rand(100) < 10) {
				outputText("You barely manage to avoid a wide sweeping attack from marble by rolling under it.", false);
				combatRoundOver();
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str + 40 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			damage /= 2;
			if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				outputText("You easily deflect and block the damage from Marble's wide swing.", false);
			}
			outputText("Marble easily hits you with a wide, difficult to avoid swing.  (" + damage + " damage).", false);
			if(damage > 0) player.takeDamage(damage);
			statScreenRefresh();
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.marbleScene.marbleFightWin();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.marbleScene.marbleFightLose();
		}

		public function Marble()
		{
			trace("Marble Constructor!");
			init01Names("", "Marble", "marble", "Before you stands a female humanoid with numerous cow features, such as medium-sized cow horns, cow ears, and a cow tail.  She is very well endowed, with wide hips and a wide ass.  She stands over 6 feet tall.  She is using a large two handed hammer with practiced ease, making it clear she is much stronger then she may appear to be.");
			init02Female(VAGINA_WETNESS_NORMAL,VAGINA_LOOSENESS_NORMAL);
			init03BreastRows("F");
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY);
			init05Body("6'4",HIP_RATING_CURVY,BUTT_RATING_LARGE,LOWER_BODY_TYPE_HOOFED);
			init06Skin("pale");
			init07Hair("brown",13);
			init08Face();
			init09PrimaryStats(75,70,35,40,25,45,40);
			init10Weapon("large hammer","hammer-blow",10);
			init11Armor("tough hide",5);
			init12Combat(0,0,1,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(7,rand(5) + 25);
			init14FixedDrop(weapons.L_HAMMR);
			initX_Tail(TAIL_TYPE_COW);
			initX_Specials(marbleSpecialAttackOne,marbleSpecialAttackTwo);

		}

	}

}