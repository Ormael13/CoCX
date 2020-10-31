package classes.StatusEffects {
import classes.StatusEffectClass;
import classes.StatusEffectType;

    public class HeatEffect extends StatusEffectClass {
        public static const TYPE:StatusEffectType = register("heat", HeatEffect);
        public function HeatEffect () {
            super(TYPE);
        }

        override public function onAttach():void {
            ApplyEffect();
        }

        public function ApplyEffect():void {
            host.buff("Heat").setStats({"lib.mult":value2, "sens":value2*100/2}).withText("Heat");
        }

        override public function onRemove():void {
            host.buff("Heat").remove();
        }

        //public function CurrentLibidoBuff():Number {
        //}
        //public function CurrentFertilityBuff():Number {
        //}
    }
}

