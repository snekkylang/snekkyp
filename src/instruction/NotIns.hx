package instruction;

import instruction.Instruction.Info;

class NotIns extends Instruction {

    public function new(info:Info) {
        super("Not", info);
    }
}