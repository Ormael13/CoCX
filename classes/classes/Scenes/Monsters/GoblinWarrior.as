package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class GoblinWarrior extends Goblin
	{
		public function slash():void {
			outputText("The goblin charges at you with her sword!  As soon as she approaches you, she swings her sword! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid her slash!");
			}
			else {
				outputText("You fail to dodge and you get hit. ");
				//Get hit
				var damage:int = str + weaponAttack + rand(40);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		public function shieldBash():void {
			outputText("The goblin charges at you with her shield! ");
			if (player.getEvasionRoll()) {
				outputText("You avoid her shield bash!");
			}
			else {
				outputText("Her shield hits you! ");
				//Get hit
				if (rand(100) < 40 && player.findPerk(PerkLib.Resolute) < 0) {
					outputText("The impact from the shield has left you with a concussion. <b>You are stunned.</b> ");
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
				var damage:int = str + rand(10);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		public function warriorSpecial():void {
			if (rand(2) == 0) slash();
			else shieldBash();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.goblinWarriorScene.goblinWarriorRapeIntro();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0 || flags[kFLAGS.SFW_MODE] > 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She growls and kicks you in the head, making your vision swim. As your sight fades, you hear her murmur, \"<i>Fucking dicks can't even bother to grow a dick or cunt.</i>\"", false);
				game.combat.cleanupAfterCombat();
			} 
			else {
				game.goblinWarriorScene.gobboWarriorBeatYaUp();
			}
		}
		
		public function GoblinWarrior() 
		{
			this.a = "the ";
			this.short = "goblin warrior";
			this.imageName = "goblinwarrior";
			this.long = "The goblin before you is slightly taller than most of the goblins and her hair is a deep red hue. She has dark green skin and her ears are pierced in several spots. Unlike most goblins you've seen, this one is well armed. She's wearing a metal breastplate that covers her torso, offering her more defense. There are more straps covering her legs than a goblin typically has. She's wielding a shortsword in her right hand and a wooden shield in her left hand. Despite how well-armed she is, her nipples and cooter are exposed.";
			if (player.hasCock()) this.long += "  She's clearly intent on beating you up just so she can forcibly make you impregnate her.";
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 44 + rand(7);
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "dark green";
			this.hairColor = "red";
			this.hairLength = 4;
			initStrTouSpeInte(75, 50, 70, 72);
			initLibSensCor(45, 45, 60);
			this.weaponName = "sword and shield";
			this.weaponVerb = "slash";
			this.weaponAttack = 14;
			this.armorName = "platemail";
			this.armorDef = 12;
			this.bonusHP = 400;
			this.lust = 50;
			this.lustVuln = 0.44;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 16;
			this.gems = rand(15) + 15;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.GREEN_D,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			this.special3 = warriorSpecial;
			checkMonster();
		}
		
	}

}