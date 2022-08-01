package classes.Scenes.Dungeons.DemonLab 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Incels 
	{
		
		public function Incels() 
		{
		this.a = "the ";
			this.short = "Incels";
			//this.imageName = "goblinwarrior";
			this.long= "";
			this.plural = true;
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 104 + rand(7);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.hairLength = 2;
			this.horns.count = 2;
			initStrTouSpeInte(275, 400, 390, 30);
			initWisLibSensCor(40, 945, 50, 100);
			this.weaponName = "black claws";
			this.weaponVerb = "slash";
			this.weaponAttack = 100;
			this.armorName = "skin";
			this.armorDef = 81;
			this.armorMDef = 59;
			this.bonusHP = 1400;
			this.bonusLust = 990;
			this.lust = 50;
			this.lustVuln = 0.44;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 40;
			this.gems = rand(50) + 75;
			//I don't know how to add regeneration, physical resistance, or the lust to damage special ability I want them to have. 
			this.drop = new WeightedDrop().
					add(UseableLib.D_SCALE,5).
					add(UseableLib.LETHITE,2).
					add(jewelries.POWRRNG,1).
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.ToughHide, 0, 0, 0, 0);
			this.createPerk(PerkLib.ClawTraining, 0, 0, 0, 0);

			checkMonster();
		}
		private function IncelRush(){
		outputText("The creatures rush at you, their blackened nails flashing. Sheer numbers weigh against you, and the creatures land strike after strike!")
		createStatusEffect(StatusEffects.Attacks, 0 + rand(6),0,0,0);
		//if rand = 0
		//outputText("You see the creatures massing for their attack. Before they can surround you, you kick one of the banquet tables over, delaying their charge long enough for you to put some distance between you and the horde. ")
		}
		private function DraftSupportStart (){
			outputText("You notice the pink gas spilling from the lab washing over the horde. The reaction is immediate, the animalistic creatures letting out wails of anger, some even scratching at their bodies as if to rid themselves of the effects. As the gas washes over you, blood rushes to your cheeks.")
			player.dynStats("lus", Math.round(60+(player.lib*1.1)));
		}
		private function DraftSupportCont (){
			outputText("Lustdraft gas continues to wash over the battlefield, weakening your knees and sending the horde in front of you into a frenzy. You need to end this fight as fast as possible!")
			player.dynStats("lus", Math.round(10+(player.lib*0.7)));
		}
		private function Rip&TearUntilYourDone(){
			outputText("The mass of frenzied creatures grab hold of you. One takes an arm, another bites at you with sharp fangs. You struggle, but as soon as you throw one off you, another takes its place, and more are piling on, burying you under a tidal wave of flesh! You are buried under the incels’ writhing mass, and they’re still trying to tear you apart!")
			}
			private function RipCont(){
				outputText("The horde rips at your body, scratches and bites coming at you from every side. You try to escape, but for every hold you break, another claw comes in to grab you.")
				createStatusEffect(StatusEffects.Attacks, 3 ,0,0,0);
			}
			private function RipBreakOut():void {
		outputText("You manage to get your elbow into the mouth of one particularly tenacious creature, and it recoils, headbutting another by accident. The two begin fighting, and the flailing starts a miniature brawl between the Sexless freaks. You feel the weight on you lessening, and you heave, sending two more of the creatures tumbling. You scramble, pulling yourself out, but as you do, the creatures refocus on you, almost immediately. \n\n"); 
		//make the horde take some damage here
		}
	}

}