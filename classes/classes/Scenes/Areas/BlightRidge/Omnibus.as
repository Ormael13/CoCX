/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.BlightRidge
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.DynamicItems;
import classes.Scenes.Monsters.AbstractSuccubus;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Omnibus extends AbstractSuccubus
	{
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) cleanupAfterCombat();
			else {
				game.flags[kFLAGS.DEMONS_DEFEATED]++;
				SceneLib.defiledravine.demonScene.defeatOmnibus();
			}
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) SceneLib.dungeons.riverdungeon.defeatedByMistOmnibus();
			else {
				if (inDungeon) SceneLib.dungeons.ebonlabyrinth.defeatedByStrayDemon();
				else SceneLib.dungeons.factory.doLossIncubus(false); //it's alright, the scene uses [themonster] and [monster he] to specify.
			}
		}
		
		public function Omnibus()
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.short = "mist omnibus";
				initStrTouSpeInte(220, 180, 165, 140);
				initWisLibSensCor(140, 150, 75, 100);
				this.weaponAttack = 39;
				this.armorDef = 36;
				this.armorMDef = 6;
				this.bonusHP = 775;
				this.bonusLust = 273;
				this.level = 48;
				this.additionalXP = 300;
			    this.gems = rand(40) + 50;
				this.createPerk(PerkLib.OverMaxHP, 49, 0, 0, 0);
			}
			else if (inDungeon) { //EL check
				this.short = "stray omnibus";
                var mod:int = SceneLib.dungeons.ebonlabyrinth.enemyLevelMod;
                initStrTouSpeInte(280 + 12*mod, 245 + 15*mod, 210 + 15*mod, 175 + 5*mod);
                initWisLibSensCor(175 + 5*mod, 180 + 10*mod, 90 + 8*mod, 100);
                this.weaponAttack = 52 + 5*mod;
                this.armorDef = 48 + 12*mod;
                this.armorMDef = 8 + 2*mod;
                this.bonusHP = 1150 + 1150*mod;
                this.bonusLust = 336 + 18*mod;
                this.level = 63 + 5*mod;
				this.gems = mod > 20 ? 0 : Math.floor((80 + rand(40)) * Math.exp(0.3*mod));
				this.additionalXP = mod > 20 ? 0 : Math.floor(700 * Math.exp(0.3*mod));
				this.createPerk(PerkLib.OverMaxHP, (63 + 5*mod), 0, 0, 0);
			}
			else {
				this.short = "omnibus";
				initStrTouSpeInte(160, 115, 120, 110);
				initWisLibSensCor(110, 120, 60, 100);
				this.weaponAttack = 26;
				this.armorDef = 24;
				this.armorMDef = 4;
				this.bonusHP = 575;
				this.bonusLust = 209;
				this.level = 29;
				this.additionalXP = 70;
			    this.gems = rand(40) + 20;
				this.createPerk(PerkLib.OverMaxHP, 29, 0, 0, 0);
			}
			this.a = "the ";
			this.imageName = "omnibus";
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) this.long = "She stands about six feet tall and is hugely voluptuous, her impressive breasts wobble delightfully as she moves.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  She is wearing rags that cover only a tiny fraction of her glowing vein covered body, concealing just her naughty bits to make the whole display more erotic.  Her crotch is a combination of both genders – a drooling cunt topped with a thick demonic shaft, sprouting from where a clit should be.  She's using a leather whip as a weapon.";
			else this.long = "She stands about six feet tall and is hugely voluptuous, her impressive breasts wobble delightfully as she moves.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  She is wearing rags that cover only a tiny fraction of her body, concealing just her naughty bits to make the whole display more erotic.  Her crotch is a combination of both genders – a drooling cunt topped with a thick demonic shaft, sprouting from where a clit should be.  She's using a leather whip as a weapon.";
			// this.plural = false;
			this.createCock(10,1.5,CockTypesEnum.DEMON);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.bodyColor = "purple";
			this.hairColor = "black";
			this.hairLength = 13;
			this.weaponName = "whip";
			this.weaponVerb="whipping";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.lust = 30;
			this.lustVuln = .5;
			this.randomDropChance = 0.1;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_LESSER
			};
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.drop = new WeightedDrop().
						add(weapons.WHIP, 2).
						add(consumables.LETHITE, 5).
						add(useables.PCSHARD, 5);
			}
			else {
				this.drop = new WeightedDrop().
						add(consumables.BIMBOLQ, 1).
						add(consumables.BROBREW, 1).
						add(weapons.WHIP, 2).
						add(consumables.SUCMILK, 12).
						add(consumables.INCUBID, 12);
			}
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
	}
}
