package instruction;

class NegateIns extends Instruction {

    public function new(byteIndex:Int) {
        super("Negate", byteIndex);
    }
}