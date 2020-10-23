package instruction;

import object.Object;

class ConstantIns extends Instruction {

    public final index:Int;
    public final value:Object;

    public function new(index:Int, value:Object, bytePosition:Int) {
        super("Constant", bytePosition);

        this.index = index;
        this.value = value;
    }

    override function toString():String {
        return '$mnemonic {index: $index, value: $value}';
    }
}