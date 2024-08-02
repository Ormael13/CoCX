package classes.Transformations.Transformations {
import classes.GeneticMemories.BallsMem;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.Transformations.*;

/**
 * Base class for transformation events.
 */
public class BallsTransformations extends MutationsHelper {
	/*
    *	 ██████   █████  ██     ██     ███████
    * 	 ██   ██ ██   ██ ██     ██     ██
    * 	 ██████  ███████ ██     ██     ███████
    * 	 ██   ██ ██   ██ ██     ██          ██
    * 	 ██████  ██   ██ ██████ ██████ ███████
    */

	/*
        */
	public const BallsNone:Transformation = new SimpleTransformation("Remove Bals",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "[pg]Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>";

				if (doOutput) outputText(desc);
				if (!player.hasStatusEffect(StatusEffects.Uniball)) player.createStatusEffect(StatusEffects.Uniball, 0, 0, 0, 0);
				player.balls = 0;
				player.ballSize = 1;
			},
			// is present
			function ():Boolean {
				return player.balls == 0;
			}
	);

	public const BallsDuo:Transformation = new SimpleTransformation("Two balls only",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";

				if (player.balls < 2) {
					player.ballSize = 1;
					if (rand(2) == 0) desc += "A nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed sack.";
					else desc += "You gasp in shock as a sudden pain racks your crotch. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new pair of testes.</b>[pg]";
				}
				else
					desc += "Your scrotum slowly shrinks until they seem to have reached a normal size. <b>It feels as if your extra balls have fused together, leaving you with a pair of balls.</b>[pg]";

				if (doOutput) outputText(desc);
				player.balls = 2;
				Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.DUO));
			},
			// is present
			function ():Boolean {
				return player.balls == 2;
			}
	);

	public function BallsQuad(size: int = 1, forceQuad: Boolean = false):Transformation {

		return new SimpleTransformation("Four balls",
				// apply
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.balls == 0) {
						player.balls = 2;
						player.ballSize = size;
						desc += "You gasp in shock as a sudden pain racks your abdomen. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new set of testes.</b>";
						if (forceQuad) {
							desc += "After a minute, two more testes drop down into your [sack], your skin stretching even more to accommodate them. Once the pain clears, you examine <b>your new quartet of testes.</b>"
							player.balls = 4;
						}
					}
					else {
						desc += "You gasp in shock as a sudden pain racks your abdomen. Within seconds, two more testes drop down into your [sack], your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new quartet of testes.</b>";
						player.balls = 4;
					}

					if (doOutput) outputText(desc);

					if (player.balls == 2)
						Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.DUO));
					else
						Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.QUAD));
				},
				// is present
				function ():Boolean {
					return player.balls == 4;
				}
		);
	}

	public const BallsTrap:Transformation = new SimpleTransformation("Trap pouch",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";

				if (player.balls < 2) {
					player.balls = 2;
					desc += "You gasp in shock as a sudden pain racks your abdomen. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new pair of testes.</b>[pg]";
				}
				else
				if (player.ballSize > 1) desc += "You feel a delicate tightening sensation around your [balls].  The sensation upon this most sensitive part of your anatomy isn't painful, but the feeling of your balls getting smaller is intense enough that you stifle anything more than a sharp intake of breath only with difficulty.[pg]";
				player.ballSize = 1;
				if (!player.hasStatusEffect(StatusEffects.Uniball))
					desc += "You whimper as once again, your balls tighten and shrink.  Your eyes widen when you feel the gentle weight of your testicles pushing against your crotch, and a few hesitant swings of your [butt] confirm what you can feel - you've tightened your balls up so much they no longer hang beneath your [cocks], but press perkily upwards.  Heat ringing your ears, you explore your new sack with a careful hand.  "+
							"You are deeply grateful you apparently haven't reversed puberty, but you discover that though you still have " + num2Text(player.balls) + ", your balls now look and feel like one: one cute, tight little sissy parcel, its warm, insistent pressure upwards upon the joining of your thighs a never-ending reminder of it.[pg]"

				if (doOutput) outputText(desc);
				if (!player.hasStatusEffect(StatusEffects.Uniball))
					player.createStatusEffect(StatusEffects.Uniball, 0, 0, 0, 0);

				Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.TRAP));
			},
			// is present
			function ():Boolean {
				return player.hasStatusEffect(StatusEffects.Uniball);
			}
	);
	/*
*/
}
}
