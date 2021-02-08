package instruction;

class DuplicateIns extends Instruction {

    public function new(byteIndex:Int) {
        super("Duplicate", byteIndex);
    }
}