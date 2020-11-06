package instruction;

class StoreIndexIns extends Instruction {

    public function new(byteIndex:Int) {
        super("StoreIndex", byteIndex);
    }
}
