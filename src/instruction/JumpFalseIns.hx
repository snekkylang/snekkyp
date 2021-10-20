package instruction;

import instruction.Instruction.Info;

class JumpFalseIns extends Instruction {

    public final index:Int;

    public function new(index:Int, info:Info) {
        super("JumpFalse", info);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}