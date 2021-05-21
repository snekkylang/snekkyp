package instruction;

import instruction.Instruction.Info;

class HashIns extends Instruction {

    public final size:Int;

    public function new(size:Int, info:Info) {
        super("Hash", info);

        this.size = size;
    }

    override function toString():String {
        return '$mnemonic {size: $size}';
    }
}