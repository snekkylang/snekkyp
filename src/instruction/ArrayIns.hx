package instruction;

import instruction.Instruction.Info;

class ArrayIns extends Instruction {

    public final size:Int;

    public function new(size:Int, info:Info) {
        super("Array", info);

        this.size = size;
    }

    override function toString():String {
        return '$mnemonic {size: $size}';
    }
}