package instruction;

typedef Info = {
    bytePosition: Int,
    fileName: String,
    line:Int,
    linePos:Int
}

class Instruction {

    public final mnemonic:String;
    public final info:Info;

    public function new(mnemonic:String, info:Info) {
        this.mnemonic = mnemonic;
        this.info = info;
    }

    public function toString() {
        return '$mnemonic';
    }
}