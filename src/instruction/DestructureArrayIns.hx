package instruction;

class DestructureArrayIns extends Instruction {

    public final index:Int;

    public function new(index:Int, bytePosition:Int) {
        super("DestructureArray", bytePosition);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}