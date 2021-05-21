package instruction;

import instruction.Instruction.Info;

class LoadIndexIns extends Instruction {

    public function new(info:Info) {
        super("LoadIndex", info);
    }
}