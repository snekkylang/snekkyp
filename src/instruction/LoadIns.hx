package instruction;

class LoadIns extends Instruction {

    public final index:Int;

    public function new(index:Int, byteIndex:Int) {
        super("Load", byteIndex);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}