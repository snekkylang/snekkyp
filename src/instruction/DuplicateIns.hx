package instruction;

import instruction.Instruction.Info;

class DuplicateIns extends Instruction {

    public function new(info:Info) {
        super("Duplicate", info);
    }
}