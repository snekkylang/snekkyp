package instruction;

import instruction.Instruction.Info;

class NotEqualsIns extends Instruction {

    public function new(info:Info) {
        super("NotEquals", info);
    }
}