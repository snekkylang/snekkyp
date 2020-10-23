package instruction;

class HashIns extends Instruction {

    public final size:Int;

    public function new(size:Int, byteIndex:Int) {
        super("Hash", byteIndex);

        this.size = size;
    }

    override function toString():String {
        return '$mnemonic {size: $size}';
    }
}