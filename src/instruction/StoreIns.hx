package instruction;

import instruction.Instruction.Info;

class StoreIns extends Instruction {

    public final index:Int;
    public final name:String;

    public function new(index:Int, name:String, info:Info) {
        super("Store", info);

        this.index = index;
        this.name = name;
    }

    override function toString():String {
        return '$mnemonic {index: $index} :: {name: $name}';
    }
}