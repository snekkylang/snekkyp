package instruction;

import instruction.Instruction.Info;

class JumpNotIns extends Instruction {

    public final index:Int;

    public function new(index:Int, info:Info) {
        super("JumpNot", info);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}