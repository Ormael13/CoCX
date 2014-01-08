package classes.Scenes.Dungeons.HelDungeon
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Brigid extends Monster 
	{

		//Attack One: Hot Poker, Right Up Your Ass!
		private function brigidPoke():void {
			outputText("Brigid stalks forward with confidence, her shield absorbing your defensive blows until she's right on top of you. She bats your [weapon] aside and thrashes you with her hot poker, scalding your " + player.skin() + " and sending you reeling.");
			//(Effect: Heavy Damage)
			var damage:Number = Math.round((str + weaponAttack) - rand(player.tou) - player.armorDef);
			if(damage < 30) damage = 30;
			damage = player.takeDamage(damage);
			outputText(" (" + damage + ")");
			game.combatRoundOver();
		}

		//Attack Two: SHIELD BOP! OOM BOP!
		private function brigidBop():void {
			outputText("The harpy feints at you with her poker; you dodge the blow, but you leave yourself vulnerable as she spins around and slams her heavy shield into you, knocking you off balance.");
			//(Effect: Stagger/Stun)
			var damage:Number = 5;
			damage = player.takeDamage(5);
			outputText(" (" + damage + ")");
			if(player.hasPerk("Resolute") >= 0) outputText("  Of course, your resolute posture prevents her from accomplishing much.");
			else player.createStatusAffect("Stunned",0,0,0,0);
			game.combatRoundOver();
		}

		//Attack Three: Harpy Ass Grind GO!
		private function BrigidAssGrind():void {
			outputText("Brigid grins as she approaches you.  She handily deflects a few defensive blows and grabs you by the shoulders.  She forces you onto your knees and before you can blink, has turned around and smashed your face into her ass!  \"<i>Mmm, you like that, don'tcha?</i>\" she growls, grinding her huge, soft ass across your face, giving you an up-close and personal feel of her egg-laying hips.");
			game.dynStats("lus", 30);
			game.combatRoundOver();
		}
		override protected function performCombatAction():void
		{
			if(player.hasStatusAffect("Stunned") >= 0) {
				player.removeStatusAffect("Stunned");
				if(rand(2) == 0) BrigidAssGrind();
				else brigidPoke();
				return;
			}
			if(rand(3) == 0) BrigidAssGrind();
			else if(rand(2) == 0) brigidBop();
			else brigidPoke();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.brigidScene.pcDefeatsBrigid();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.brigidScene.pcDefeatedByBrigid();
		}

		public function Brigid()
		{
			init01Names("", "Brigid the Jailer", "brigid", "Brigid is a monster of a harpy, standing a foot taller than any other you've seen. She's covered in piercings, and her pink-dyed hair is shaved down to a long mohawk. She's nude, save for the hot poker in her right hand and the shield in her left, which jingles with every step she takes thanks to the cell keys beneath it.");
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE,LOWER_BODY_TYPE_HARPY);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(90,60,120,40,40,45,50);
			init10Weapon("poker","burning stab",30);
			init11Armor("armor",20);
			init12Combat(1000,20,.25,TEMPERMENT_LOVE_GRAPPLES);
			init13Level(19,rand(25)+140,50);
			initX_Wings(WING_TYPE_FEATHERED_LARGE);
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Horns(HORNS_DEMON);
		}
		
	}

}