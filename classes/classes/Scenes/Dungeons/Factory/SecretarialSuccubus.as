package classes.Scenes.Dungeons.Factory
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.Dungeons.Factory;
import classes.Scenes.Monsters.AbstractSuccubus;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class SecretarialSuccubus extends AbstractSuccubus
	{
		public var factory:Factory = new Factory();
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.gender > 0) {
				var dildo:Function = (player.hasKeyItem("Deluxe Dildo") >= 0 ? succubusGetsDildoed : null);
				
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you rape her?", true);
					player.dynStats("lus", 1);
					EngineCore.simpleChoices("Yes", factory.doRapeSuccubus, "", null, "", null, "", null, "No", factory.doLeaveSuccubus);
					if (player.hasKeyItem("Deluxe Dildo") >= 0) EngineCore.addButton(1, "Dildo Rape", factory.dildoSuccubus);
				} else if (player.lust>=33){
					outputText("You smile in satisfaction as the " + short + " gives up on fighting you and starts masturbating, begging for you to fuck her.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you fuck her?", true);
					player.dynStats("lus", 1);
					EngineCore.simpleChoices("Yes", factory.doRapeSuccubus, "", null, "", null, "", null, "No", factory.doLeaveSuccubus);
					if (player.hasKeyItem("Deluxe Dildo") >= 0) EngineCore.addButton(1, "Dildo Rape", factory.dildoSuccubus);
				} else {
					doNext(factory.doLeaveSuccubus);
				}
			} else {
				doNext(factory.doLeaveSuccubus);
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				doNext(factory.doLossSuccubus);
			}
		}

		public function SecretarialSuccubus() {
			this.a = "the ";
			this.short = "secretarial succubus";
			this.imageName = "secretarialsuccubus";
			this.long = "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 60;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.skinTone = "blue";
			this.hairColor = "blond";
			this.hairLength = 13;
			initStrTouSpeInte(60, 50, 85, 35);
			initWisLibSensCor(35, 80, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="slap";
			this.weaponAttack = 12;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 6;
			this.bonusHP = 200;
			this.bonusLust = 40;
			this.lust = 30;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 12;
			this.gems = rand(25) + 20;
			this.additionalXP = 75;
			this.drop = new WeightedDrop(consumables.LACTAID, 1);
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			this.special1 = kissAttack;
			this.special2 = seduceAttack;
			this.special3 = whipAttack;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
        //[FACTORY SUCCUBUS]
        private function succubusGetsDildoed():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Your defeated opponent eyes you warily as you advance upon her, thrusting her chest forwards lewdly, with a hopeful gleam in her eye.  That gleam vanishes in sudden surprise when you stop and pull the oblong form of Tamani's dildo from your pouches.  The busty demon giggles happily, \"<i>I, like, love those things!  Those little sluts never let me keep one though!  Greedy bitches...</i>\"\n\n");
            EngineCore.outputText("The succubus spreads her fishnet-coated legs, exposing her moist vulva while she reclines against a table, beckoning you forwards.  Well, you certainly didn't expect her to be so willing, but you may as well go through with it!  You push up her tiny skirt for better access and position the toy for a perfect insertion. She begs, \"<i>Quit teasing me and just jam it in me already!  Honey, I just want to feel it stretch me while my hot little box drools all over it.  Would you mind giving my clitty a lick too?  It's aching for a touch.</i>\"\n\n");
            EngineCore.outputText("You see her button poking between her folds, far larger than the mortal women you've met, and you feel more than a little compelled to do as she's asked.   The toy slides in easily, though the further it penetrates her dark-blue cunt, the thicker it gets, and the more difficult it becomes to force it deeper inside.  Eventually you get it the entire way in.  The pair of you, demon and champion, watch together as her glistening cunt-lips are slowly forced apart, stretched wider and wider by the exotic dildo.  She giggles as you watch transfixed, and begins stroking her fingers all over her juicy outer folds while she asks, \"<i>Are you going to rape me or just stare at my cunt all day?</i>\"\n\n");
            EngineCore.outputText("Shaking your head and blushing ");
            if(player.cor < 50) EngineCore.outputText("in shame");
            else EngineCore.outputText("with lust");
            EngineCore.outputText(", you begin tracing your finger over her clit, smiling when it twitches.  It begins visibly growing every time you touch it, puffing up until it's nearly four inches of smooth purple succubus sex.   Glancing down further, you see her cunt stretched massively, the pink blob spreading her so wide it looks like any more swelling would dislocate her hips.  You give her clit a little squeeze and the succubus cums, noisily and happily.  Her clit spasms wildly, growing slightly bigger before beginning to wilt as the cunt-contractions force the dildo out.\n\n");
            EngineCore.outputText("With a sodden 'plop', it hits the floor, revealing a gaping canal dripping with the dildo's pink aphrodisiacs.  The secretary-impersonating slut flops back, fondling her tits through her clothing as she languidly sighs, \"<i>Oooooh yeah those little cunts can make a good toy.</i>\"   She props herself up and begins touching her sex, holding open the gaped love-tunnel for you as she teases, \"<i>Yes, you've defeated me, like, for sure, mighty champion!  I don't think I'm capable of standing up to stop you! *Giggle*</i>\"\n\n");
            EngineCore.outputText("Good.  You pick up the toy ");
            if(player.cor > 75) EngineCore.outputText("giving it a long lick to taste the succubi's delicious flavor ");
            EngineCore.outputText("and put it away.  When you glance back towards the Succubus, she's gone, leaving you alone and horny...");
            player.dynStats("lus", (20+player.lib/5+player.cor/10));
            cleanupAfterCombat();
        }

	}

}
