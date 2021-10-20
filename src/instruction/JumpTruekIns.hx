package instruction;

import instruction.Instruction.Info;

class JumpTrueIns extends Instruction {

    public final index:Int;

    public function new(index:Int, info:Info) {
        super("JumpTrue", info);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}