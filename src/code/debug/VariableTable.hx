package code.debug;

import haxe.io.BytesInput;

private typedef VariableEntry = {index:Int, start:Int, end:Int, name:String};

class VariableTable {

    final table:Array<VariableEntry> = [];

    public function new() {}

    public function resolveIndex(index:Int) {
        for (entry in table) {
            if (entry.index == index) {
                return entry.name;
            }
        }

        return 'var$index';
    }

    public function fromByteCode(byteCode:BytesInput):VariableTable {
        final tableSize = byteCode.readInt32();
        final startPosition = byteCode.position;

        while (byteCode.position < startPosition + tableSize) {
            final index = byteCode.readInt32();
            final start = byteCode.readInt32();
            final end = byteCode.readInt32();
            final nameLength = byteCode.readInt32();
            final name = byteCode.readString(nameLength);

            table.push({index: index, start: start, end: end, name: name});
        }

        return this;
    }
} 