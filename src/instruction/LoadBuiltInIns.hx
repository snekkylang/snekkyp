package instruction;

class LoadBuiltInIns extends Instruction {

    public final index:Int;
    public final name:String;

    public function new(index:Int, name:String, byteIndex:Int) {
        super("LoadBuiltIn", byteIndex);

        this.index = index;
        this.name = name;
    }

    override function toString():String {
        return '$mnemonic {index: $index, name: $name}';
    }
}