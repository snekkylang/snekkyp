package instruction;

import instruction.Instruction.Info;

class PopIns extends Instruction {

    public function new(info:Info) {
        super("Pop", info);
    }
}