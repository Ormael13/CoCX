package classes.Scenes.Areas.HighMountains 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;

public class Phoenix extends Monster
	{
		protected function doubleSlash():void {
			outputText("You fall back under a hail of feints and jabs as your enemy darts at you, swinging furiously. The sheer number of blows the phoenix lays against you is incredible, forcing you backwards as you try to deflect the flurry of deadly strikes.  ");
			if (player.getEvasionRoll()) {
				outputText("You are able to parry one of her blows with enough force to push her back, giving you a little more breathing room.");
			}
			if (combatBlock(true)) {
				outputText("You are able to raise your [shield] in time to block the phoenix's blows.");
			}
			else {
				outputText("Seeing an opening, the phoenix forces her way through your guard with a quick pair of powerful strikes. ");
				//Get hit
				var damage:int = str + weaponAttack + rand(80);
				player.takePhysDamage(damage, true);
				//Get hit again
				damage = str + weaponAttack + rand(80);
				player.takePhysDamage(damage, true);
			}
		}
		
		protected function phoenixFireBreath():void {
			if (!hasStatusEffect(StatusEffects.Uber)) {
				outputText("Suddenly the phoenix disengages from you and loops through the air, giving out a loud cry before she starts to barrel down at you. She’s clearly building up for something, so you’d better wait until she makes her move if you want a chance to dodge!");
				createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
			}
			else {
				if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) {
					outputText("You dive to the ground just as the phoenix breathes a great gout of flame at you. The fire blooms over your back, singeing your [armor], but doesn’t harm you. As she swoops low you see the phoenix scowl, looking quite disappointed, but it’s clear she isn’t done yet!");
				}
				//MASSIVE DAMAGE!
				else {
					var damage:int = str + weaponAttack + 300 + rand(250);
					if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
					if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
					if (player.hasStatusEffect(StatusEffects.Blizzard)) {
						player.addStatusValue(StatusEffects.Blizzard, 1, -1);
						outputText("As she zooms over you a great gout of flame erupts from the phoenix’s mouth! You dive out of the way, but all too late. The wall of fire rolls over covering you blizzard you as you leap through it, the brief contact with the inferno searing both you and your [armor] slightly due to still swirling around you ice shards. ");
						damage *= 0.2;
					}
					else {
						outputText("As she zooms over you a great gout of flame erupts from the phoenix’s mouth! You dive out of the way, but all too late. The wall of fire rolls over you as you leap through it, the brief contact with the inferno searing both you and your [armor] badly. ");
					}
					damage = Math.round(damage);
					player.takeMagicDamage(damage, true);
				}
				removeStatusEffect(StatusEffects.Uber);
			}
		}
		
		protected function lustBang():void {
			outputText("\"<i>Here, CATCH!</i>\" The phoenix shouts, lobbing a small, circular canister at you before ducking behind her sturdy shield. Oh shit!");
			if (player.getEvasionRoll()) {
				outputText("Luckily, the metal cylinder bounces off the uneven terrain of the mountain, giving you just enough time to dive away as a huge cloud of pink erupts into the air. The phoenix glances around her shield, face darkening as she sees you readying yourself for another strike instead of writhing on the ground in an oversensitive pile of lust.");
			}
			else {
				outputText("You cough and hack, waving your arms to try and dissipate the fog, but by the time the cloud has faded you feel lightheaded and lusty. Your");
				if (player.hasCock()) outputText("shaft quickly engorges inside your armour, already leaking precum down your leg");
				if (player.hasCock() && player.hasVagina()) outputText("whilst your");
				if (player.hasVagina()) outputText("thighs are suddenly soaked by a torrent of girlcum as your body reacts to the potent chemicals");
				outputText(".");
				var lustDmg:Number = (30 + rand(30)) * (EngineCore.lustPercent()/100);
				player.dynStats("lus", lustDmg, "scale", false);
				outputText(" <b>(<font color=\"#ff00ff\">" + (Math.round(lustDmg*10)/10) + "</font>)</b>");
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (hasStatusEffect(StatusEffects.Uber)) {
				phoenixFireBreath();
				return;
			}
			switch (choice) {
				case 0:
					eAttack();
					break;
				case 1:
					doubleSlash();
					break;
				case 2:
					phoenixFireBreath();
					break;
				case 3:
					lustBang();
					break;
				default:
					eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.highMountains.phoenixScene.winAgainstPhoenix();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.highMountains.phoenixScene.loseToPhoenix();
			}
		}
		
		public function Phoenix() 
		{
			this.a = "the ";
			this.short = "phoenix";
			this.imageName = "phoenix";
			this.long = "The figure facing you is one of the dangerous hybrids of the Salamander and Harpy races; a Phoenix created by the self proclaimed harpy \"Queen\". Her appearance is close to a normal, crimson-feathered harpy, save for a few noticeable additions. Wings larger than a normal harpy’s sprout from her back, probably to make up for the fact that the usual harpy armwings fade into scaled forearms, an obvious marker of her Salamander parentage. Her lower body is much the same, feather-covered hips and thighs merging with scales around the knee and ending in a clawed lizard foot; not to mention the long, fiery tail that swishes to and from behind her as she circles you. \n\nStanding perhaps six and a half feet tall, her large breasts strain against the tarnished metal of her vest, just as her ample hips threaten to burst free from her tight loincloth. A half-erect lizard cock pokes out pushing the cloth to one side and allowing for a clear view of her slick, puffy pussy just below it. Her scimitar cuts great swaths through the air as she darts through the air above you, taking full advantage of the open space you find yourselves in.";
			// this.plural = false;
			this.createCock(8, 1.2, CockTypesEnum.LIZARD);
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 6 * 12 + 6;
			this.tailType = Tail.SALAMANDER;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_JIGGLY;
			this.lowerBody = LowerBody.SALAMANDER;
			this.skin.growCoat(Skin.SCALES,{color:"crimson"});
			this.skin.base.color = "light";
			this.hairColor = "red";
			this.hairLength = 16;
			initStrTouSpeInte(125, 110, 120, 84);
			initWisLibSensCor(80, 50, 30, 45);
			this.weaponName = "scimitar and shield";
			this.weaponVerb="slash";
			this.weaponAttack = 41;
			this.armorName = "chainmail and loincloth";
			this.armorDef = 37;
			this.bonusHP = 800;
			this.bonusLust = 10;
			this.lust = 10;
			this.lustVuln = .7;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = 60 + rand(45);
			this.drop = new ChainedDrop().add(useables.EBONBLO,1/20)
					.add(weapons.SCIMITR,1/20)
					.elseDrop(consumables.NOCELIQ);
			this.wings.type = Wings.FEATHERED_PHOENIX;
			this.special1 = doubleSlash;
			this.special2 = phoenixFireBreath;
			this.special3 = lustBang;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
