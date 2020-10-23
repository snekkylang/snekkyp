package code.debug;

import haxe.io.BytesInput;

class LocalVariableTable {

    final table:Map<Int, String> = new Map();

    public function new() {}

    public function define(byteIndex:Int, name:String) {
        table.set(byteIndex, name);
    }

    public function resolve(byteIndex:Int) {
        return if (table.exists(byteIndex)) {
            table.get(byteIndex);
        } else if (byteIndex > 0) {
            resolve(byteIndex - 1);
        } else {
            null;
        }
    }

    public function fromByteCode(byteCode:BytesInput):LocalVariableTable {
        final tableSize = byteCode.readInt32();
        final startPosition = byteCode.position;

        while (byteCode.position < startPosition + tableSize) {
            final byteIndex = byteCode.readInt32();
            final localNameLength = byteCode.readInt32();
            final localName = byteCode.readString(localNameLength);

            table.set(byteIndex, localName);
        }

        return this;
    }
} 