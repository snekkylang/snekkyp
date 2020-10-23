package instruction;

class Instruction {

    public final mnemonic:String;
    public final bytePosition:Int;

    public function new(mnemonic:String, bytePosition:Int) {
        this.mnemonic = mnemonic;
        this.bytePosition = bytePosition;
    }

    public function toString() {
        return '$mnemonic';
    }
}