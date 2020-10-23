package instruction;

class PopIns extends Instruction {

    public function new(byteIndex:Int) {
        super("Pop", byteIndex);
    }
}