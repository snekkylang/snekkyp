package instruction;

import code.debug.LineNumberTable.Position;

class StoreIndexIns extends Instruction {

    public function new(byteIndex:Int) {
        super("StoreIndex", byteIndex);
    }
}
