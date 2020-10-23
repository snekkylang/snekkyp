package instruction;

class CallIns extends Instruction {
   
    public final parametersCount:Int;

    public function new(parametersCount:Int, bytePosition:Int) {
        super("Call", bytePosition);

        this.parametersCount = parametersCount;
    }

    override function toString():String {
        return '$mnemonic {parametersCount: $parametersCount}';
    }
}