package instruction;

import instruction.Instruction.Info;

class BitNotIns extends Instruction {

    public function new(info:Info) {
        super("BitNot", info);
    }
}