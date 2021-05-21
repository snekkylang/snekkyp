package instruction;

import instruction.Instruction.Info;

class CallIns extends Instruction {
   
    public final parametersCount:Int;

    public function new(parametersCount:Int, info:Info) {
        super("Call", info);

        this.parametersCount = parametersCount;
    }

    override function toString():String {
        return '$mnemonic {parametersCount: $parametersCount}';
    }
}