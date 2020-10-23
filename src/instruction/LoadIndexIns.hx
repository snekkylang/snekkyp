package instruction;

class LoadIndexIns extends Instruction {

    public function new(byteIndex:Int) {
        super("LoadIndex", byteIndex);
    }
}