package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.Goblin;
import classes.Scenes.SceneLib;
import classes.Scenes.UniqueSexScenes;
import classes.internals.*;

public class Tamani extends Goblin
	{

		public var uniquuuesexscene:UniqueSexScenes = new UniqueSexScenes();
		
		override protected function goblinTeaseAttack():void
		{
			if(flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] > 0) {
				tamaniHypnoTease();
				return;
			}
			super.goblinTeaseAttack();
		}

//New Tease option:
		public function tamaniHypnoTease():void {
			var selector:Number = rand(3);
			//Choose 1 of 3 variations
			if(selector == 0) outputText("Tamani smiles and shifts her leather straps, pulling one into the puffy gash that is her vagina.  She groans out loud, sliding the studded leather band into her outer lips and sawing it along her clit.  Her whole body blushes as she pulls it free, running a fingertip up the now wet strip of leather, \"<i>Mmm, can't you see how much my pussy needs a man inside it?  Be a good husband and fuck Tamani full!  You know you want to.</i>\"\n\n");
			if(selector == 1) outputText("Tamani saunters up to you, sliding her fingers down to each side of her pussy and spreading them.  Your eyes are drawn to her honeyed tunnel, unable to look away she gets closer.  She whispers, \"<i>Your cock knows what it needs.  Just be a good husband and obey your dick, it KNOWS how badly you need mistress's pussy.</i>\"\n\n");
			if(selector == 2) outputText("Tamani turns around and bends down, pressing her hands into the dirt as she kicks her legs apart.  Your stare open-mouthed at her bouncy ass-cheeks and the tantalizingly wet entrance of her slit.  She smirks and offers, \"<i>You've cum so many times inside me, why resist when you can give in and feel that pleasure again today?  Come on husband, don't make Tamani beg...</i>\"\n\n");

			//REACTIONS
			//LOW HYPNO VALUE:
			if(flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] < 5) {
				selector = rand(3);
				if(selector == 0) outputText("You reluctantly pull your stare away from the heavenly entrance between her legs.  There's an urge to walk over to her and plunge yourself inside her over and over, but you dismiss it.");
				if(selector == 1) outputText("You find it hard to pull your gaze from her inviting twat, but you manage.  You shake your head, clearing away thoughts of fertilizing your wife.  Her rhetoric must be getting to you.");
				if(selector == 2) outputText("No matter the case, her actions shifted a fair bit of your blood-flow to your groin.");
			}
			//MEDIUM HYPNO VALUE:
			else if(flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] < 10) {
				selector = rand(2);
				if(selector == 0) {
					outputText("With effort you manage to wrench your eyes away from the inviting folds of Tamani's vagina.  ");
					if(player.cockTotal() > 1) outputText("Each of y");
					else outputText("Y");
					outputText("our " + multiCockDescriptLight());
					if(player.lust > 80) outputText(" drips pre-cum");
					else if(player.lust > 40) outputText(" grows harder");
					else outputText(" hardens");
					outputText(" from the sexual sight, and you feel a compulsion to rush to your wife and take her on the spot.  Obviously she's not really your wife, but after so many fuckings it kind of makes sense to think of her that way.");
					if(player.lust < 70) outputText("  Still, you don't want to fuck her right now!");
				}
				else {
					outputText("Struggling, you pull your eyes back into your head and away from Tamani's gorgeous slit.  You shudder, feeling ");
					if(player.cockTotal () > 1) outputText("each of ");
					outputText("your " + player.multiCockDescriptLight());
					if(player.lust <= 41) outputText(" thicken perceptibly");
					else if(player.lust <= 81) outputText(" twitch eagerly");
					else outputText("drip pre-cum");
					outputText(", responding to the overly sensual goblin's body.  You start to approach her, but stop yourself, realizing you were about to pick up your wife and fuck her on the spot.  You know she's not really your wife, but you have a hard time thinking of her as anything else, save for maybe your mistress.");
					if(player.lust < 70) outputText("  Regardless, you're resolute in your desire not to fuck her right now!");
				}
			}
			//HIGH HYPNO VALUE
			else {
				selector = rand(2);
				if(selector == 0) {
					outputText("You barely manage to step yourself from lunging forward to bury your mouth between your mistress's legs.  Hard and trembling between your legs, ");
					if(player.cockTotal() > 1) outputText("each of ");
					outputText("your [cocks] aches with need.  You battle with the compulsion to kneel before your short, stacked mistress and perform your duties as her breeder husband.");
				}
				else {
					outputText("You wrench your gaze from the juicy mound before you with great difficulty.  The desire to submit to your wife and fuck her on the spot rages through your body, melting your resistance into liquid lust and pooling it in your groin.  ");
					if(player.cockTotal() > 1) outputText("Each of y");
					else outputText("Y");
					outputText("our [cocks] pulses and dribbles pre-cum, aching to do its duty and fire load after load into Tamani's perfect pussy.");
				}
			}
			player.dynStats("lus", (rand(player.lib/5)+3+(flags[kFLAGS.TAMANI_TIMES_HYPNOTISED])));
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("Tamani is defeated!", true);
			} else {
				outputText("Tamani gives up on defeating you and starts masturbating!", true);
			}
			if(player.lust >= 33 && player.cockTotal() > 0 && flags[kFLAGS.SFW_MODE] <= 0) {
				outputText("  You could fuck her, but if that's the case why did you bother fighting her?\n\nWhat do you do to her?");
				var temp:Function = null;
				var temp2:Function = null;
				var temp3:Function = null;
				if (player.hasCock() && player.cockThatFits(analCapacity()) >= 0) temp = SceneLib.forest.tamaniScene.tamaniAnalShits;
				if (player.pcCanUseUniqueSexScene()) temp3 = uniquuuesexscene.pcUniqueSexScenesChoiceMenu;
				//NOT PREGGERS
				if (!SceneLib.forest.tamaniScene.pregnancy.isPregnant && player.canOvipositSpider()) {
					temp2 = SceneLib.forest.tamaniScene.tamaniBeaten;
				}
				EngineCore.simpleChoices("Fuck", SceneLib.forest.tamaniScene.tamaniSexWon, "Buttfuck", temp, "Lay Eggs", temp2, "U. Sex Scenes", temp3, "Leave", SceneLib.combat.cleanupAfterCombatImpl);
			}
			else SceneLib.combat.cleanupAfterCombatImpl();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory){
				if(player.cockTotal() > 0) {
					if(rand(2) == 0) SceneLib.forest.tamaniScene.tamaniSexLost();
					else SceneLib.forest.tamaniScene.tamaniSexLetHer();
				}else {
					outputText("Tamani sighs as you begin to lose conscious, \"<i>You dummy, why'd you get rid of the fun parts?</i>\"", true);
					SceneLib.combat.cleanupAfterCombatImpl();
				}
			} else {
				if(player.cockTotal() > 0) {
				//hypnoslut loss scene
				if(game.flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] > 19 && rand(2) == 0) {
					SceneLib.forest.tamaniScene.getRapedByTamaniYouHypnoSlut();
				} else if(rand(2) == 0) SceneLib.forest.tamaniScene.tamaniSexLost();
				else SceneLib.forest.tamaniScene.tamaniSexLetHer();
				} else {
					outputText("You give into your lusts and masturbate, but Tamani doesn't seem to care.  She kicks and punches you over and over, screaming, \"<i>You dummy, why'd you get rid of the fun parts?</i>\"", true);
					player.takePhysDamage(10000);
					SceneLib.combat.cleanupAfterCombatImpl();
				}
			}
		}

		public function Tamani()
		{
			super(false);
			this.a = "";
			this.short = "Tamani";
			this.imageName = "tamani";
			this.long = "She keeps her arms folded across her " + SceneLib.forest.tamaniScene.tamaniChest() + " and glares at you.  The little thing is only about four feet tall, with pink and black dyed hair cut into a cute little 'do.  The greenish-gray skin of her breasts bulges out around her arms, supported by a few leather straps, amplifying her cleavage.  Her cunt lips are pierced multiple times, inflamed, and slightly parted.  There really isn't any clothing on her to hide them, just more of the ever-present straps wrapping around her thighs.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 55, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 40;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "greenish gray";
			this.hairColor = "pink and black";
			this.hairLength = 16;
			initStrTouSpeInte(37, 58, 55, 62);
			initWisLibSensCor(60, 64, 65, 50);
			this.weaponName = "fists";
			this.weaponVerb="tiny punch";
			this.weaponAttack = 1;
			this.armorName = "leather straps";
			this.armorDef = 1;
			this.armorMDef = 1;
			this.bonusHP = 60;
			this.bonusLust = 20;
			this.lust = 40;
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 8;
			this.gems = rand(35) + 10;
			this.drop = new WeightedDrop().add(consumables.GOB_ALE,4)
					.addMany(1,
							consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.PURPDYE,
							consumables.INCUBID,
							consumables.REDUCTO,
							consumables.L_BLUEG,
							null);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			checkMonster();
		}
		
	}

}
