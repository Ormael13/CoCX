/**
 * ...
 * @author Candian Snas
 */
package classes.Scenes.Dungeons.DemonLab 
{
import classes.PerkLib;

public class ScientistGunner extends IncubusScientist
{
	
	public function ScientistGunner() 
	{
		super();
		this.short = "Scientist Gunner";
        initStrTouSpeInte(152, 105, 135, 305);
        initWisLibSensCor(110, 195, 120, 100);
        this.weaponAttack = 116;
		this.armorDef = 38;
		this.armorMDef = 23;
        this.bonusHP = 600;
        this.bonusLust = 368;
		this.level = 53;
        this.additionalXP = 300;
        this.gems = rand(30) + 200;
        this.createPerk(PerkLib.OverMaxHP, 53, 0, 0, 0);
	}

    private function serum():void {
        outputText("The demon scientist reaches into his lab coat, pulling out a hypodermic needle.\n"
            + "“<i>The side effects are nasty...but I need the power now.</i>” He sticks himself, and he inhales sharply. He doesn’t look any different, but as he cocks his weapon, you notice the vein pulsing on his forehead. He’s way faster now!");
        buff("Serum").addStats({"spe": 250, "str": -75, "int": -75});
        createPerk(PerkLib.Evade, 0, 0, 0, 0);
        createPerk(PerkLib.ImprovedEvade, 0, 0, 0, 0);
        createPerk(PerkLib.GreaterEvade, 0, 0, 0, 0);
    }
	
	private function ForHisNeutralSpecialHeWieldsAGun():void {
        outputText("The demon scientist lines you up in his sights, pulling the trigger several times.")
        //Miss:
        //Determine if evaded
        if (player.getEvasionRoll()) {
            outputText("You dodge the bullets, and they fly past, taking small chunks out of the stone wall behind you.");
        }
        else {
            var damage:Number = 0;
			damage += Math.round((inte + wis + spe + 190 + rand(10) + (player.newGamePlusMod() * 3)) * 10);
            outputText("You can’t even see the projectile as it flies, striking you in the [chest].");
            player.takePhysDamage(damage * 3);
        }
    }
}
}