package classes.Scenes.Monsters
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.*;

	public class GoblinAssassin extends Monster
	{
		protected function goblinDrugAttack():void {
			var temp2:Number = rand(5);
			var color:String = "";
			if (temp2 == 0) color = "red";
			if (temp2 == 1) color = "green";
			if (temp2 == 2) color = "blue";
			if (temp2 == 3) color = "white";
			if (temp2 == 4) color = "black";
			//Throw offensive potions at the player
			if (color != "blue") {
				outputText(capitalA + short + " uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.", false);
			}
			//Drink blue pots
			else {
				outputText(capitalA + short + " pulls out a blue vial and uncaps it, swiftly downing its contents.", false);
				if (HPRatio() < 1) {
					outputText("  She looks to have recovered from some of her wounds!\n", false);
					addHP(eMaxHP() /4);
				}
				else outputText("  There doesn't seem to be any effect.\n", false);
			}
			//Dodge chance!
			if ((player.findPerk(PerkLib.Evade) >= 0 && rand(10) <= 3) || (rand(100) < player.spe/5)) {
				outputText("\nYou narrowly avoid the gush of alchemic fluids!\n", false);		
			}
			//Get hit!
			//Temporary heat
			if (color == "red") {
				outputText("\nThe red fluids hit you and instantly soak into your skin, disappearing.  Your skin flushes and you feel warm.  Oh no...\n", false);
				if (player.findStatusEffect(StatusEffects.TemporaryHeat) < 0) player.createStatusEffect(StatusEffects.TemporaryHeat,0,0,0,0);
			}
			//Green poison
			if (color == "green") {
				outputText("\nThe greenish fluids splash over you, making you feel slimy and gross.  Nausea plagues you immediately - you have been poisoned!\n", false);
				if (player.findStatusEffect(StatusEffects.Poison) < 0) player.createStatusEffect(StatusEffects.Poison,0,0,0,0);
			}
			//sticky flee prevention
			if (color == "white") {
				outputText("\nYou try to avoid it, but it splatters the ground around you with very sticky white fluid, making it difficult to run.  You'll have a hard time escaping now!\n", false);
				if (player.findStatusEffect(StatusEffects.NoFlee) < 0) player.createStatusEffect(StatusEffects.NoFlee,0,0,0,0);
			}
			//Increase fatigue
			if (color == "black") {
				outputText("\nThe black fluid splashes all over you and wicks into your skin near-instantly.  It makes you feel tired and drowsy.\n", false);
				player.changeFatigue(10 + rand(25));
			}
			combatRoundOver();
			return;
		}
		//Lust Needle
		protected function lustNeedle():void {
			outputText("With a swift step, the assassin vanishes, her movements too quick for you to follow. You take a sharp breath as you feel her ample thighs clench your head in between them, her slick cunt in full view as you take in her scent.");
			//Miss
			if (player.getEvasionRoll()) 
			{
				//Miss: 
				outputText("\nYou’ve already prepared, however, as you hold your breath and grab the goblin by her sides. Unhindered by her advance, you take the opportunity to move backwards, throwing the goblin off balance and leaving you only faintly smelling of her pussy.");
				game.dynStats("lus", rand(player.lib/10) +4);
			}
			//Hit: 
			else 
			{
				outputText("\nYou’re far too distracted to notice the needle injected into the back of your neck, but by the time she flips back into her original position you already feel the contents of the syringe beginning to take effect.");
				game.dynStats("lus", rand(player.lib/4) +20);
			}
			combatRoundOver();
		}
		//Dual Shot
		protected function dualShot():void {
			outputText("The assassin throws a syringe onto the ground, shattering it and allowing the dissipating smoke from its contents to distract you long enough for her to slip underneath you. With a quick flick of her wrists two needles are placed into her hands, though you’ve already caught wind of her movements.");
			//Miss: 
			if (player.getEvasionRoll()) 
			{
				outputText("\nYou jump backwards, far enough to avoid her quick thrust upwards as she attempts to lick the area in which your crotch once stood. Realising her situation, she quickly removes herself from the ground and faces you, more determined than before.");
			}
			//Hit: 
			else {
				outputText("\nBefore you can do anything to stop her, she lifts her head and takes a swift lick of your crotch, taking a small moan from you and giving her enough time to stab into the back of your knees. She rolls out of the way just as you pluck the two needles out and throw them back to the ground. They didn’t seem to have anything in them, but the pain is enough to make you stagger. ");
				//(Medium HP loss, small lust gain)
				var damage:int = int((str + weaponAttack + 40) - rand(player.tou) - player.armorDef);
				damage = player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		//Explosion
		protected function goblinExplosion():void {
			outputText("Without a second thought, the assassin pulls a thin needle from the belt wrapped around her chest and strikes it against the ground, causing a flame to erupt on the tip. She twirls forward, launching the needle in your direction which subsequently bursts apart and showers you with heat.");
			outputText("\nYou shield yourself from the explosion, though the goblin has already lit a second needle which she throws behind you, launching your body forwards as it explodes behind your back. ");
			//(High HP loss, no lust gain)
			var damage:int = 25 + rand(75);
			damage = player.takeDamage(damage, true);
			combatRoundOver();
		}
		override public function defeated(hpVictory:Boolean):void
		{
			game.goblinAssassinScene.gobboAssassinRapeIntro();
			
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0 || flags[kFLAGS.SFW_MODE] > 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She growls and kicks you in the head, making your vision swim. As your sight fades, you hear her murmur, \"<i>Fucking dicks can't even bother to grow a dick or cunt.</i>\"", false);
				game.combat.cleanupAfterCombat();
			} 
			else {
				game.goblinAssassinScene.gobboAssassinBeatYaUp();
			}
		}
		public function GoblinAssassin(noInit:Boolean=false)
		{
			if (noInit) return;
			this.a = "the ";
			this.short = "goblin assassin";
			this.imageName = "goblinassassin";
			this.long = "Her appearance is that of a regular goblin, curvy and pale green, perhaps slightly taller than the norm. Her wavy, untamed hair is a deep shade of blue, covering her pierced ears and reaching just above her shoulders. Her soft curves are accentuated by her choice of wear, a single belt lined with assorted needles strapped across her full chest and a pair of fishnet stockings reaching up to her thick thighs. She bounces on the spot, preparing to dodge anything you might have in store, though your eyes seem to wander towards her bare slit and jiggling ass. Despite her obvious knowledge in combat, she’s a goblin all the same – a hard cock can go a long way.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 90, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,50,0,0,0);
			this.tallness = 35 + rand(4);
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "dark green";
			this.hairColor = "blue";
			this.hairLength = 7;
			initStrTouSpeInte(45, 55, 110, 95);
			initLibSensCor(65, 35, 60);
			this.weaponName = "needles";
			this.weaponVerb="stabbing needles";
			this.armorName = "leather straps";
			this.bonusHP = 70;
			this.lust = 50;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 10;
			this.gems = rand(50) + 25;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE, 5).
					addMany(1, consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.PURPDYE);// TODO this is a copy of goblin drop. consider replacement with higher-lever stuff
			checkMonster();
		}

		override protected function performCombatAction():void
		{
			var actions:Array = [eAttack,goblinDrugAttack,lustNeedle,dualShot,goblinExplosion];
			actions[rand(actions.length)]();
		}
	}
}
