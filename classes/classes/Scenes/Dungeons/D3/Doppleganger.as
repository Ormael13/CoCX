package classes.Scenes.Dungeons.D3 
{
	import classes.BreastRowClass;
	import classes.Cock;
	import classes.Monster;
	import classes.VaginaClass;
	import classes.StatusEffects;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class Doppleganger extends Monster
	{
		private var _roundCount:int = 0;
		
		public function mirrorAttack(damage:Number):void
		{
			this.createStatusEffect(StatusEffects.MirroredAttack, 0, 0, 0, 0);
			
			outputText("As you swing your [weapon] at the doppleganger, " + player.mf("he", "she") + " smiles mockingly, and mirrors your move exactly, lunging forward with " + player.mf("his", "her") + " duplicate " + weaponName + ".");
			
			// Cribbing from combat mechanics - if the number we got here is <= 0, it was deflected, blocked or otherwise missed.
			// We'll use this as our primary failure to hit, and then mix in a bit of random.
			// tl;dr this avoids a bunch of weapon effects and perks, but given the specific means of attack, I think it actually makes sense overall. (Basically having to pull back from what you would normally do mid-attack to successfully land any kind of hit).
			if (damage > 0 && rand(8) < 6)
			{
				outputText("  At the very last moment, you twist downwards and strike into your opponent’s trunk, drawing a gasp of pain from " + player.mf("him", "her") +" as " + player.mf("he", "she") +" clumsily lashes " + player.mf("his", "her") + " own " + weaponName +" over you. It’s your turn to mirror " + player.mf("him", "her") +", smiling mockingly at " + player.mf("his", "her") +" rabid snarls as " + player.mf("he", "she") +" resets " + player.mf("him", "her") +"self, " + player.mf("his", "her") +" voice bubbling and flickering for a moment as " + player.mf("he", "she") +" tries to maintain control. <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
				this.HP -= damage;
			}
			else
			{
				outputText("  Your");
				if (player.weaponName == "fists") outputText(" [weapon]");
				else outputText(" [weapon]s");
				outputText(" meet with a bone-jarring impact, and you are sent staggering backwards by a force exactly equal to your own.");

				outputText("\n\n“<i>Try again, [name],</i>” the doppelganger sneers, derisively miming your falter. “<i>C’mon. Really test yourself.</i>”");
			}
			addTalkShit();
		}
		
		public function mirrorTease(damage:Number, successful:Boolean):void
		{
			clearOutput();
			outputText("You move your hands seductively over your body, and - you stop. The doppelganger stops too, staring at you with wicked coyness, " + player.mf("his", "her") +" hands frozen on " + player.mf("his", "her") +" form exactly where yours are. Glaring back, you begin your slow, lustful motions again, as your reflection does the exact same thing. It’s a lust off!");
			
			if (damage > 0 && successful)
			{
				outputText("\n\nYou determinedly display and twist your carnality to what you know are its best advantages, ignoring what the doppelganger is doing- you’re extremely familiar with it, after all. After a few slow seconds crawl past a blush settles upon your reflection’s face, and "+ player.mf("he", "she") +" hands falter and stop being able to follow yours as "+ player.mf("he", "she") +" stares at what you’re doing.");

				outputText("\n\n“<i>It’s- it’s been so long,</i>” " + player.mf("he", "she") +" groans, managing to break away to stare into your smirking, smouldering eyes with lust-filled rage. “<i>But I’ll have that, I’ll have everything soon enough!</i>”");
				
				this.applyTease(damage);
			}
			else
			{
				outputText("You keep moving and displaying your body as best you can, but an overwhelming amount of self-awareness creeps in as your doppelganger mockingly copies you. Is that really what you look like when you do this? It looks so cheap, so clumsy, so desperate. As a blush climbs onto your face you feel a vague sense of vertigo as control of the situation shifts- you copy the doppelganger as "+ player.mf("he", "she") +" cruelly continues to slide "+ player.mf("his", "her") +" hands over "+ player.mf("his", "her") +" body exaggeratedly.");

				outputText("\n\n“<i>What’s the matter, [name]?</i>” " + player.mf("he", "she") +" breathes, staring lustfully into your eyes as " + player.mf("he", "she") +" sinks both hands into " + player.mf("his", "her") +" crotch and bends forward, forcing you close to " + player.mf("his", "her") +" face. “<i>Never tried it in front of a mirror? You were missing out on the nasty little tramp you are.</i>”");
				
				game.dynStats("lus", damage + (rand(7) - 3));
			}
			addTalkShit();
		}
		
		private function addTalkShit():void
		{
			statScreenRefresh();
			
			if (HP < 1)
			{
				doNext(game.combat.endHpVictory);
				return;
			}
			
			if (lust >= eMaxLust())
			{
				doNext(game.combat.endLustVictory);
				return;
			}
			
			if (player.HP < 1)
			{
				doNext(game.combat.endHpLoss);
				return;
			}
			
			if (player.lust >= player.maxLust())
			{
				doNext(game.combat.endLustLoss);
				return;
			}
			
			switch (_roundCount)
			{
				case 0:
					outputText("\n\n“<i>You feel it, don’t you?</i>” The doppelganger whispers, crooking your mouth into a vicious grin. “<i>The transfer. The mirror is a vacuum without a being inside it; it reaches out for someone to complete it. Your being, to be exact. Mine wants to be free a lot more than yours. Ten years more, to be exact.</i>”");
					outputText("\n\n[He] goes on in a dull croon as [he] continues to circle you, moving with the odd, syncopated jerks of a creature in a body that has only existed for a couple of minutes. “<i>Just let it happen, [name]. You can’t beat me. I am you, only with the knowledge and powers of a demon. Accept your fate.</i>”");
					outputText("\n\nA weird fluttering feeling runs up your arm, and with a cold chill you look down to see it shimmer slightly, as if you were looking at it through running water.");
					outputText("\n\n<b>You need to finish this as fast as you can.</b>");
					break
					
				case 1:
					outputText("\n\n“<i>Do you know, I can’t even remember what gender I was before I got stuck in that mirror?</i>” the doppelganger says, as [he] slides a hand between your thighs’ mirror counterparts thoughtfully. “<i>I loved changing all the time. Being stuck as one gender seemed so boring when the tools to shift from one shape to the next were always there. That’s why this was my punishment. Forced to change all the time, at the unthinking behest of whoever happened to look into this cursed thing. You have to give Lethice credit, she’s not just cruel, she’s got imagination too. It’s a hell of a combination. I’d hate to see what she had in store for you.</i>”");
					break;
					
				case 2:
					outputText("\n\n“<i>This, though... this I like, [name].</i>” [He] closes [his] eyes and");
					if (player.hasCock()) outputText(" strokes [his] [cock]");
					else if (player.hasVagina()) outputText(" slides two fingers into [his] [vagina] and gently frigs [himself]");
					else outputText(" slips a hand ");
					outputText(" underneath [his] " + this.armorName +". The sheer bizarreness of seeing yourself masturbate gives you pause; again the unreality intensifies, and you feel yourself shimmer uncertainly. “<i>Once I’m out of here, I’m going to hang onto this. Revel in not changing my form for once, as a tribute to the kind soul who gave me it!</i>”");
					outputText("\n\nIt’s getting harder to ignore the way your body shimmers and bleeds contrast at the edges, whilst your reflection only becomes more and more sharply defined.");
					outputText("\n\n<b>This is something, you realize with a growing horror, which is really going to happen if you don’t stop it.</b>");
					break;
					
				case 3:
					outputText("\n\n“<i>Your memories flow to me [name], as you fade like a memory. I can taste them...</i>” You struggle to stay focused, try and force your body and mind not to blur like a fingerprint on a windowpane as the doppelganger sighs beatifically.");
					outputText("\n\n“<i>Not bad, not bad. You led quite an interesting life for an Ingnam peasant, didn’t you? Got around. Not enough sex, though. Nowhere near enough sex. Don’t worry- I’ll correct that mistake, in due course.</i>”");
					break;
					
				case 4:
					outputText("\n\n“<i>Did you really think you could defeat Lethice, peasant?</i>” the doppelganger roars. [He] moves and speaks with confidence now, [his] old twitchiness gone, revelling and growing into [his] new form.");
					outputText("\n\nYou don’t dare open your mouth to hear what pale imitation of that voice comes out. “<i>Oh, by grit, crook and luck you’ve gotten this far, but defeat the demon queen? You, who still cling onto your craven, simple soul and thus know nothing of demonhood, of its powers, of its sacrifices? I am doing you and the world a favor here, [name]-that-was, because I am not just taking this fine body but also the mantel it so clumsily carried. With my knowledge and your brute physicality, I will have my revenge on Lethice, and the world will be free of her and her cruelty!</i>” [He] screams with laughter. The ringing insanity of it sounds increasingly muffled to you, as if it were coming through a pane of glass.");
					outputText("\n\n<b>You have time and strength for one last gambit...</b>");
					break;
				
				case 5:
					outputText("\n\nThe shimmering intensifies for a moment as something... shifts....");
					
					game.dynStats("lus+", 1000);
					
					break;
					
				default:
					outputText("\n\n“<i>How did you even survive?</i>” the doppelganger looks in confusion. “<i>Regardless, I'm still taking your body.</i>”");
					break;
			}
			
			_roundCount++;
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.d3.doppleganger.punchYourselfInTheBalls();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.d3.doppleganger.inSovietCoCSelfFucksYou();
		}
		
		public function handleSpellResistance(spell:String):void
		{
			outputText("The mirror demon barely even flinches as your fierce, puissant fire washes over [him].");

			outputText("\n\n“<i>Picked up a few things since you’ve been here, then?</i>” [he] yawns. Flickers of flame cling to [his] fingers, its radiance sputtering and burning away, replaced by a livid black color. “<i>Serf magic. Easy to pick up, easy to use, difficult to impress with. Let me show you how it’s really done!</i>” [He] thrusts [his] hands out and hurls a pitiless black fireball straight at you, a negative replica of the one you just shot at [him].");
			
			if (spell == "fireball")
			{
				player.takeDamage(player.level * 10 + 45 + rand(10), true);
			}
			else if (spell == "whitefire")
			{
				player.takeDamage(10 + (player.inte / 3 + rand(player.inte / 2)), true);
			}
			
			addTalkShit();
		}
		
		public function handlePlayerWait():void
		{
			outputText("Your doppleganger similarly opts to take a momentary break from the ebb and flow of combat.");
			addTalkShit();
		}
		
		override public function doAI():void
		{
			if (findStatusEffect(StatusEffects.Stunned) >= 0) {
				removeStatusEffect(StatusEffects.Stunned);
				outputText("Your duplicate is too stunned, buying you another round!");
				combatRoundOver();
				return;
			}
			outputText("Your duplicate chuckles in the face of your attacks.");
			addTalkShit();
		}
		
		public function Doppleganger() 
		{
			this.a = "the ";
			this.short = "doppleganger";
			this.long = ""; // Needs to be set to supress validation errors, but is handled by an accessor override.
			this.imageName = "doppleganger";
			this.plural = false;
			
			this.tallness = player.tallness;
			
			if (player.balls > 0)
			{
				this.balls = player.balls;
				this.ballSize = player.ballSize;
			}
			else
			{
				this.balls = 0;
				this.ballSize = 0;
			}
			
			this.hoursSinceCum = player.hoursSinceCum;
			
			hipRating = player.hipRating;
			if (hipRating < 1) hipRating = 1;
			buttRating = player.buttRating;
			if (buttRating < 1) buttRating = 1;
			lowerBody = player.lowerBody;
			skinDesc = player.skinDesc;
			initStrTouSpeInte(player.str, player.tou, player.spe, player.inte);
			initLibSensCor(player.lib, player.sens, player.cor);
			if (cor < 50) cor = 50;
			faceType = player.faceType;
			skinType = player.skinType;
			
			this.bonusHP = 250;
			
			this.weaponName = player.weaponName;
			this.weaponAttack = player.weaponAttack;
			this.weaponVerb = player.weaponVerb;
			
			this.armorDef = player.armorDef;
			this.armorName = player.armorName;
			
			this.level = player.level;
			
			this.ass.analLooseness = player.ass.analLooseness;
			this.ass.analWetness = player.ass.analWetness;
			
			if (player.cocks.length > 0)
			{
				for (var i:int = 0; i < player.cocks.length; i++)
				{
					this.createCock((player.cocks[i] as Cock).cockLength, (player.cocks[i] as Cock).cockThickness, (player.cocks[i] as Cock).cockType);
				}
			}
			
			if (player.vaginas.length > 0)
			{
				this.createVagina();
				(this.vaginas[0] as VaginaClass).vaginalLooseness = player.vaginas[0].vaginalLooseness;
				(this.vaginas[0] as VaginaClass).vaginalWetness = player.vaginas[0].vaginalWetness;
				(this.vaginas[0] as VaginaClass).virgin = player.vaginas[0].virgin;
			}
			//Genderless get forced to have a cunny
			if (player.vaginas.length == 0 && player.cocks.length == 0)
			{
				this.createVagina();
				(this.vaginas[0] as VaginaClass).vaginalLooseness = 2;
				(this.vaginas[0] as VaginaClass).vaginalWetness = 6;
				(this.vaginas[0] as VaginaClass).virgin = false;
			}
			this.breastRows = [];
			
			for (i = 0; i < player.breastRows.length; i++)
			{
				this.createBreastRow();
				var tbr:BreastRowClass = this.breastRows[i];
				var sbr:BreastRowClass = player.breastRows[i];
				
				tbr.breastRating = sbr.breastRating;
				tbr.breasts = sbr.breasts;
				tbr.fuckable = sbr.fuckable;
				tbr.lactationMultiplier = sbr.lactationMultiplier;
				tbr.milkFullness = sbr.milkFullness;
				tbr.nipplesPerBreast = sbr.nipplesPerBreast;
			}
			this.pronoun1 = "[he]";
			this.pronoun2 = "[him]";
			this.pronoun3 = "[his]";
			this.drop = NO_DROP;
			
			checkMonster();
		}
		
		override public function get long():String
		{
			var str:String = "";
			
			str += "You are fighting the doppelganger. " + player.mf("He", "She") +" is a ";
			str += String(Math.floor(player.tallness / 12) + " foot " + player.tallness % 12 + " inch tall ");
			str += player.race() + ", with " + player.bodyType() + ". ";
			
			str += player.mf("His", "Her") + " face is " + player.faceDesc() + ".";
			
			str += " "  + player.mf("His", "Her") + " " + player.hairDescript() + " is parted by";
			
			switch(player.earType)
			{
				case EARS_HORSE:
					str += " a pair of horse-like ears";
					break;
				case EARS_FERRET:
					str += " a small pair of rounded ferret ears";
					break;
				case EARS_DOG:
					str += " a pair of dog ears";
					break;
				case EARS_COW:
					str += " a pair of round, floppy cow ears";
					break;
				case EARS_ELFIN:
					str += " a large pair of pointy ears";
					break;
				case EARS_CAT:
					str += " a pair of cute, fuzzy cat ears";
					break;
				case EARS_LIZARD:
				case EARS_DRAGON:
					str += " a pair of rounded protrusions with small holes";
					break;
				case EARS_BUNNY:
					str += " a pair of floppy rabbit ears";
					break;
				case EARS_FOX:
					str += " a pair of large, adept fox ears";
					break;
				case EARS_RACCOON:
					str += " a pair of vaugely egg-shaped, furry racoon ears";
					break;
				case EARS_MOUSE:
					str += " a pair of large, dish-shaped mouse ears";
					break;
				default:
					str += " a pair of non-descript ears";
					break;
			}
			
			str += ". " + player.mf("He", "She") + " keeps exploring the area around " + player.mf("his", "her") +" mouth with " + player.mf("his", "her") +" tongue with a horribly acquisitive, sensual interest.";
			str += " " + player.mf("He", "She") + " moves around on " + player.mf("his", "her") +" " + player.legs() + " with a twitchy jerkiness, " + player.mf("his", "her") + " " + player.hipDescript() + " swinging and tightening.";
			if (player.tailType != 0) str += " " + player.mf("His", "Her") + " tail flicks this way and that.";
			str += " " + player.mf("He", "She") + " wields the exact same " + player.weaponName + " you do, and is dressed in the mirror image of your " + player.armorName +  ". ";
			if (player.biggestTitSize() >= 2) str += "It’s difficult not to notice the way the mirror image of your " + player.breastDescript(player.biggestTitRow()) + " ebbs and heaves within it.";
			
			return str;
		}
		
	}

}
