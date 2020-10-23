package instruction;

class ConcatStringIns extends Instruction {

    public function new(bytePosition:Int) {
        super("ConcatString", bytePosition);
    }
}