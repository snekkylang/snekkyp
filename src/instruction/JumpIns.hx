package instruction;

class JumpIns extends Instruction {

    public final index:Int;

    public function new(index:Int, byteIndex:Int) {
        super("Jump", byteIndex);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}