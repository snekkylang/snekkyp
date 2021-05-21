package instruction;

import instruction.Instruction.Info;
import object.Object;

class ConstantIns extends Instruction {

    public final index:Int;
    public final value:Object;

    public function new(index:Int, value:Object, info:Info) {
        super("Constant", info);

        this.index = index;
        this.value = value;
    }

    override function toString():String {
        return '$mnemonic {index: $index, value: $value}';
    }
}