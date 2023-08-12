/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Desert 
{
import classes.*;
	
public class AnubisScene extends BaseContent
	{
		
		public function AnubisScene() 
		{}

public function anubisEncounter():void {
	clearOutput();
	var genderA:Number = 0;//male
	if (rand(2) == 0) genderA = 1;
	var skinA:Number = 0;//dark-skinned
	if (rand(2) == 0) skinA = 1;
	outputText("As you wander the desert, the sound of multiple moans and lumbering feet catches your attention. Coming from your left is a group of mummies led by an animal morph, not unlike a jackal with ornamented cloths and a casting staff. "+(genderA == 1 ? "Sh" : "H")+"e walks the desert bare-chested");
	if (genderA == 1) outputText(", her "+(skinA == 1 ? "obsidian" : "dark-skinned")+" breast exposed to the wind. ");
	else outputText(". His "+(skinA == 1 ? "obsidian" : "dark-skinned")+" chest glistening with sweat, exposed to the wind. ");
	outputText("Upon seeing you, the necromantic leader points a finger, unleashing what appears to be a spell. You dodge what appears to be a skull-like energy projectile with a spectral trail as it passes right next to you before vanishing into the sand. Your jackal-headed foe makes a sneer before sternly declaring.\n\n");
	outputText("\"<i>Slaves should obey their masters. You need to be thoroughly educated so your body can properly serve those in charge</i>\" "+(genderA == 1 ? "Sh" : "H")+"e surveys you briefly with a slow nod, \"<i>You will look quite good in bandages.</i>\"\n\n");
	outputText("Looks like there's no avoiding this opponent, as "+(genderA == 1 ? "s" : "")+"he just admitted to wanting to make a slave out of you!\n\n");
    player.createStatusEffect(StatusEffects.LockingCurse, 0, 0.05, 0, 0);
	startCombat(new Anubis(genderA, skinA));
}

public function anubisDefeated(genderA:Number = 0):void {
	clearOutput();
	if (monster.HP < 1) {
		outputText("Beaten and bruised, the Anubi collapses to h"+(genderA == 1 ? "er" : "is")+" knees. The horde of sex-starved mummies quickly encroaches upon the weakened jackal.\n\n");
		outputText(""+(genderA == 1 ? "Sh" : "H")+"e cries in protest, \"<i>Wait, no, you... you can't! I am... your master!</i>\"  Yet h"+(genderA == 1 ? "er" : "is")+" words fall upon the ears of mindless cretins. In a matter of seconds, the mummies toss their master onto the ground, tearing h"+(genderA == 1 ? "er" : "is")+" clothes to shreds ");
		outputText("as "+(genderA == 1 ? "s" : "")+"he desperately attempts to fight back in a weak attempt. The slaves have usurped their master for now and amid the chaos, you spot a small haversack filled with gems. Spoils of war before you head back to camp.\n\n");
	}
	else {
		outputText(""+(genderA == 1 ? "Sh" : "H")+"e slowly collapses, rubbing h"+(genderA == 1 ? "er" : "is")+" bare chest eagerly as "+(genderA == 1 ? "s" : "")+"he clutches onto h"+(genderA == 1 ? "er" : "is")+" staff for support. H"+(genderA == 1 ? "er" : "is")+" pants fill the air as the horde of sex-starved mummies quickly encroach upon the weakened jackal.\n\n");
		outputText(""+(genderA == 1 ? "Sh" : "H")+"e glances up but with a mind clouded by lust, the jackal is helpless before the horde. "+(genderA == 1 ? "Sh" : "H")+"e hangs h"+(genderA == 1 ? "er" : "is")+" head low, submitting to the mindless cretins. In a matter of seconds, the mummies toss their master onto the ground, ");
		outputText("tearing h"+(genderA == 1 ? "er" : "is")+" clothes to shreds as "+(genderA == 1 ? "s" : "")+"he embraces the onslaught. The slaves have usurped their master for now and amid the chaos, you spot a small haversack filled with gems. Spoils of war before you head back to camp.\n\n");
	}
	cleanupAfterCombat();
}

public function anubisWon(genderA:Number = 0):void {
	clearOutput();
	outputText("As you fall to the ground, defeated, the Anubi sizes you up as "+(genderA == 1 ? "s" : "")+"he sighs in disappointment. \"<i>Not even a good piece of material. Though, it'd be a waste… Suppose you'll suffice as mummy chow.</i>\"\n\n");
	outputText("You fall unconscious as the jackal-headed humanoid lets loose h"+(genderA == 1 ? "er" : "is")+" mummy slaves on you. When you wake up you feel drained and exhausted, as if you've just walked for days without eating or sleeping. Greatly weakened, you head back to camp.");
	player.addCurse("str", 50,1);
	player.addCurse("tou", 50,1);
	cleanupAfterCombat();
}

	}

}