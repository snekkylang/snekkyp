package instruction;

class ArrayIns extends Instruction {

    public final size:Int;

    public function new(size:Int, bytePosition:Int) {
        super("Array", bytePosition);

        this.size = size;
    }

    override function toString():String {
        return '$mnemonic {size: $size}';
    }
}