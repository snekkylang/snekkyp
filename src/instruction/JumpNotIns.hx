package instruction;

class JumpNotIns extends Instruction {

    public final index:Int;

    public function new(index:Int, byteIndex:Int) {
        super("JumpNot", byteIndex);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}