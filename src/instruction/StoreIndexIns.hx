package instruction;

import instruction.Instruction.Info;

class StoreIndexIns extends Instruction {

    public function new(info:Info) {
        super("StoreIndex", info);
    }
}
