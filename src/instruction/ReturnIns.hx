package instruction;

import instruction.Instruction.Info;

class ReturnIns extends Instruction {

    public function new(info:Info) {
        super("Return", info);
    }
}