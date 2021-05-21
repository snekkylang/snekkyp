package instruction;

import instruction.Instruction.Info;

class EqualsIns extends Instruction {

    public function new(info:Info) {
        super("Equals", info);
    }
}