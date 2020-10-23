package instruction;

class ReturnIns extends Instruction {

    public function new(byteIndex:Int) {
        super("Return", byteIndex);
    }
}