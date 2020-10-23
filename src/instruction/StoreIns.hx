package instruction;

class StoreIns extends Instruction {

    final index:Int;

    public function new(index:Int, byteIndex:Int) {
        super("Store", byteIndex);

        this.index = index;
    }

    override function toString():String {
        return '$mnemonic {index: $index}';
    }
}