package instruction;

import instruction.Instruction.Info;

class NegateIns extends Instruction {

    public function new(info:Info) {
        super("Negate", info);
    }
}