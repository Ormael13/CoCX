/**
 * Created by aimozg on 18.01.14.
 */
package classes.Scenes.Quests.UrtaQuest
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.Monsters.Goblin;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GoblinBroodmother extends Goblin
	{
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.urtaQuest.goblinWin();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.urtaQuest.urtaLosesToGoblin();
		}

		public function GoblinBroodmother()
		{
			super(true);
			this.a = "the ";
			this.short = "goblin broodmother";
			this.imageName = "goblin";
			this.long = "Thanks to their corruption, it's almost impossible to discern a goblin's age by their appearance, but it's quite obvious that this one is no horny young slut looking for her first dozen or so studs.  Standing before you is an obvious veteran breeder, a proud motherwhore who doubtlessly has a sizable tribe of slutty daughters somewhere not too far away.  Maybe three and a half feet tall, she has vibrant yellow skin - a rare shade, for goblins - and a wild mane of flamboyant neon pink and neon blue striped hair that falls down her back, her long, pointed ears barely visible amongst it.  Her many pregnancies have rendered her absurdly voluptuous. I-cup tits wobble absurdly in the air before her, their jiggling expanse so big that it's a wonder she can reach out to her blatant, teat-like purple nipples. Broodmother hips flare out from her waist, making her sashay from side to side with every step. A gloriously round and luscious bubble-butt, big enough to be DD-cup tits if it were on somebody's chest, jiggles enticingly with every motion.  Lewd leather straps fight to contain her exaggerated boobs and ass, serving more to house clinking pouches and bottles than to provide any protection of her modesty.  Piercings stud her lips, nose, eyebrows, ears, nipples and clit, and her fiery red eyes smoulder as she seductively licks her lips at you.\n\nYour treacherous horse-cock aches to bury itself into this ripe, ready slut, but you have to be strong - you rather doubt she'll let you go with a single fuck, even if you are incapable of giving her the babies she craves...";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("I"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 35 + rand(4);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "dark green";
			this.hairColor = "purple";
			this.hairLength = 4;
			initStrTouSpeInte(100, 90, 80, 100);
			initWisLibSensCor(100, 81, 43, 40);
			this.weaponName = "fists";
			this.weaponVerb="tiny punch";
			this.weaponAttack = 20;
			this.armorName = "leather straps";
			this.armorDef = 5;
			this.armorMDef = 1;
			this.bonusHP = 300;
			this.bonusLust = 146;
			this.lust = 50;
			this.lustVuln = 0.5;
			this.level = 22;
			this.gems = rand(20) + 22;
			this.drop = new WeightedDrop().
					add(consumables.GOB_ALE,5).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.PURPDYE);
			this.special1 = goblinDrugAttack;
			this.special2 = goblinTeaseAttack;
			checkMonster();
		}
	}
}
