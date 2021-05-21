package instruction;

import instruction.Instruction.Info;

class ConcatStringIns extends Instruction {

    public function new(info:Info) {
        super("ConcatString", info);
    }
}