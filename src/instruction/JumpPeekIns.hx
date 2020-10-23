package instruction;

class JumpPeekIns extends Instruction {

    public final index:Int;

    public function new(index:Int, byteIndex:Int) {
        super("JumpPeek", byteIndex);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}