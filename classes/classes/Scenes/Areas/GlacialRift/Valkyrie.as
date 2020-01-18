package classes.Scenes.Areas.GlacialRift 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class Valkyrie extends Monster
	{
		public function spearAttack():void {
			outputText("The valkyrie lunges at you, jabbing with her longspear.  You dodge the first attack easily, ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE) {
				outputText("and you anticipate the upcoming spear strikes, dodging her attacks thanks to your incredible evasive ability!");
				return;
			}
			else if (evade == EVASION_FLEXIBILITY) {
				outputText("and you use your incredible flexibility to barely fold your body and avoid her attacks!");
				return;
			}
			else if (evade == EVASION_MISDIRECTION) {
				outputText("and you use technique from Raphael to sidestep and completely avoid her barrage of attacks!");
				return;
			}
			else if (evade == EVASION_SPEED || evade != null) {
				outputText("and you successfully dodge her barrages of spear attacks!");
				return;
			}
			else if (hasStatusEffect(StatusEffects.Blind) && rand(3) > 0) {
					outputText("and step away as you watch the valkyrie's blind attacks strike only air. ");
					return;
				}
			else
			{
				outputText("but she follows through with a rapid flurry of spear strikes, tearing into your " + (player.armor.name == "nothing" ? "" : "[armorName] and the underlying") + " flesh. ");
				var attacks:int = 1 + rand(3);
				var damage:int = 0;
				while (attacks > 0) {
					damage += ((str * 1.25) + rand(65));
					attacks--;
				}
				player.takePhysDamage(damage, true);
			}
		}
		
		public function shieldBash():void {
			outputText("The valkyrie feints at you with her longspear; you dodge the blow, ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE) {
				outputText("and you anticipate the upcoming shield bash, dodging her thanks to your incredible evasive ability!");
				return;
			}
			else if (evade == EVASION_FLEXIBILITY) {
				outputText("and you use your incredible flexibility to barely fold your body and avoid her shield bash!");
				return;
			}
			else if (evade == EVASION_MISDIRECTION) {
				outputText("and you use technique from Raphael to sidestep and avoid her shield bash!");
				return;
			}
			else if (evade == EVASION_SPEED || evade != null) {
				outputText("and you successfully dodge her shield bash attack!");
				return;
			}
			else if (hasStatusEffect(StatusEffects.Blind) && rand(3) > 0) {
					outputText("and step away as you watch the valkyrie's blind bash strikes only air. ");
					return;
				}
			else
			{
				outputText("but you leave yourself vulnerable as she spins around and slams her heavy shield into you, knocking you ");
				if (player.findPerk(PerkLib.Resolute) < 0 && rand(2) == 0) 
				{
					outputText("off balance. ");
					player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
				}
				else outputText("backwards. ");
				var damage:int = (((str * 1.25) + 65) + rand(65));
				player.takePhysDamage(damage, true);
			}
		}
		
		public function aerialRave():void {
			if (rand(2) == 0 || player.canFly() /* it would be stupid to do this with someone winged */) {
				spearAttack();
				return;
			}
			outputText("The valkyrie charges right at you!  You manage to dodge her spear-thrust, but she spins gracefully out of the attack and grabs you by the waist.  ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE) {
				outputText("You manage to shake her hand off thanks to evasion.  ");
				return;
			}
			else if (evade == EVASION_FLEXIBILITY) {
				outputText("Thanks to your incredibly flexibility, her hand slips off your wrist.  ");
				return;
			}
			else if (evade == EVASION_MISDIRECTION) {
				outputText("Using Raphael's technique, you slip freely from her grip.");
				return;
			}
			else if (evade == EVASION_SPEED || evade != null) {
				outputText("You suddenly jerk your arm away, causing her grip to break.");
				return;
			}
			else
			{
				outputText("Before you can react, she launches into the air, propelling the two of you upwards with her powerful wings.  You struggle, but it’s no use -- until she lets go.  You cry out in terror as you fall back to the earth, crashing painfully into a convenient snowbank, while your opponent lands gracefully a few feet away. ");
				var damage:int = (((str * 1.25) + 300) + rand(150));
				player.takePhysDamage(damage, true);
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.glacialRift.valkyrieScene.winAgainstValkyrie();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.glacialRift.valkyrieScene.loseToValkyrie();
		}
		
		public function Valkyrie() 
		{
			this.a = "a ";
			this.short = "valkyrie";
			this.imageName = "valkyrie";
			this.long = "She is a tall, pale-skinned woman with long golden locks spilling out from beneath her bronze helm.  She would look almost human, if not for the massive, powerful wings sprouting from her back, stretching perhaps a dozen feet across.  She is wearing a heavy bronze cuirass which curves perfectly around her perky C-cups, and is wielding a spear and shield as her weapons.  She has assumed the stance of a well-trained and experienced combatant, leaving few openings for you to exploit.";
			// this.plural = false;
			this.createVagina(false, 1, 1);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 7*12;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.setBaseOnly({color:"light"});
			this.hairColor = "white";
			this.hairLength = 12;
			initStrTouSpeInte(185, 165, 140, 75);
			initWisLibSensCor(75, 40, 50, 15);
			this.weaponName = "spear and shield";
			this.weaponVerb="lunge";
			this.weaponAttack = 38;
			this.armorName = "bronze plates";
			this.armorDef = 0;
			this.armorMDef = 0;
			this.bonusHP = 450;
			this.bonusLust = 10;
			this.lust = 25 + rand(15);
			this.lustVuln = 0.46;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 44;
			this.gems = 55 + rand(20);
			this.drop = new WeightedDrop()
					.add(weapons.SPEAR, 1)
					.add(shields.GREATSH, 3)
					.add(consumables.G__BOOK, 5)					
					.add(null, 15);
			this.wings.type = Wings.HARPY;
			this.wings.desc = "fluffy feathery";
			this.special1 = spearAttack;
			this.special2 = shieldBash;
			this.special3 = aerialRave;
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			checkMonster();			
		}
		
	}

}
