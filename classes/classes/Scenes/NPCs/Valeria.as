package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Lake.GooGirl;
import classes.Scenes.SceneLib;

public class Valeria extends GooGirl
	{
		public function gooArmorAI():void {
			if(rand(2) == 0 && !player.hasStatusEffect(StatusEffects.GooArmorSilence)) gooSilenceAttack();
			else if(rand(3) > 0) gooArmorAttackPhysical();
			else gooArmorAttackTwoGooConsume();
		}
		//ATTACK ONE: Greatsword
		public function gooArmorAttackPhysical():void {
			var evade:String = player.getEvasionReason();
			if(evade == EVASION_EVADE) {
				outputText("The goo-armor rushes forward and swings her sword in a mighty arc, but you evade the attack!");
			}
			else if(evade == EVASION_FLEXIBILITY) {
				outputText("The goo-armor swings a greatsword at you in a mighty arc, but your cat-like flexibility makes it easy to twist out of the way.");		
			}
			else if(evade == EVASION_MISDIRECTION) {
				outputText("The goo-armor swings a sword at you in a mighty arc, but your training with Raphael allows you to misdirect her into a miss!");	
			}
			else if(evade == EVASION_SPEED || evade != null) {
				outputText("The goo-armor rushes forward and swings her sword in a mighty arc, but you dodge it!");		
			}
			//HIT!
			else {
				outputText("The goo-armor rushes forward and swings her sword in a mighty arc.  You aren't quite quick enough to dodge her blow, and the goopy sword slams into you, throwing you back and leaving a nasty welt. ");
				var damage:Number = Math.round((str + weaponAttack) - rand(player.tou) - player.armorDef);
				if(damage <= 0) damage = 1;
				damage = player.takePhysDamage(damage, true);
			}
		}
		//ATTACK TWO: Goo Consume
		public function gooArmorAttackTwoGooConsume():void {
			outputText("Suddenly, the goo-girl leaks half-way out of her heavy armor and lunges at you.  You attempt to dodge her attack, but she doesn't try and hit you - instead, she wraps around you, pinning your arms to your chest.  More and more goo latches onto you - you'll have to fight to get out of this.");
			player.createStatusEffect(StatusEffects.GooArmorBind,0,0,0,0);
		}
		//(Struggle)
		public function struggleAtGooBind():void {
			clearOutput();
			//If fail:
			if(rand(10) > 0 && player.str/5 + rand(20) < 23) {
				outputText("You try and get out of the goo's grasp, but every bit of goop you pull off you seems to be replaced by twice as much!");
				//(If fail 5 times, go to defeat scene)
				player.addStatusValue(StatusEffects.GooArmorBind,1,1);
			}
			//If succeed: 
			else {
				outputText("You finally pull the goop off of you and dive out of her reach before the goo-girl can re-attach herself to you.  Pouting, she refills her suit of armor and reassumes her fighting stance.");
				player.removeStatusEffect(StatusEffects.GooArmorBind);
			}
		}
		//ATTACK THREE: Goo Silence
		public function gooSilenceAttack():void {
			outputText("The goo pulls a hand off her greatsword and shoots her left wrist out towards you.  You recoil as a bit of goop slaps onto your mouth, preventing you from speaking - looks like you're silenced until you can pull it off!");
			//(No spells until PC passes a moderate STR check or burns it away)
			player.createStatusEffect(StatusEffects.GooArmorSilence,0,0,0,0);
		}
		
		override protected function performCombatAction():void
		{
			gooArmorAI();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (hasStatusEffect(StatusEffects.Spar) || CoC.instance.gameSettings.sceneHunter_inst._mocking) SceneLib.valeria.pcWinsValeriaSpar();
			else SceneLib.dungeons.heltower.beatUpGooArmor();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe armored goo sighs while you exhaust yourself...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				if(hasStatusEffect(StatusEffects.Spar)) SceneLib.valeria.pcWinsValeriaSparDefeat();
				else SceneLib.dungeons.heltower.gooArmorBeatsUpPC();
			}
		}
		
		public function Valeria()
		{
			super(true);
			this.a = "a ";
			this.short = "Goo Armor";
			if (flags[kFLAGS.MET_VALERIA] > 0) {
				a = "";
				short = "Valeria";
			}
			this.imageName = "gooarmor";
			this.long = "Before you stands a suit of plated mail armor filled with a bright blue goo, standing perhaps six feet off the ground.  She has a beautiful, feminine face, and her scowl as she stands before you is almost cute.  She has formed a mighty greatsword from her goo, and has assumed the stance of a well-trained warrior.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING_WIDE);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skin.setBaseOnly({color:"blue",type:Skin.GOO});
			this.hairColor = "black";
			this.hairLength = 15;
			this.hairType = Hair.GOO;
			initStrTouSpeInte(120, 110, 100, 80);
			initWisLibSensCor(80, 90, 35, 50);
			this.weaponName = "goo sword";
			this.weaponVerb="slash";
			this.weaponAttack = 70;
			this.armorName = "armor";
			this.armorDef = 60;
			this.armorMDef = 5;
			this.bonusHP = 500;
			this.bonusLust = 155;
			this.lustVuln = .35;
			this.level = 30;
			this.gems = rand(50)+80;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}