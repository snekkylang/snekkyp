package code.debug;

import haxe.io.BytesInput;

private typedef VariableEntry = {start:Int, end:Int, name:String};

class VariableTable {

    final table:Array<VariableEntry> = [];

    public function new() {}

    public function define(start:Int, end:Int, name:String) {
        table.push({start: start, end: end, name: name});
    }

    public function resolve(byteIndex:Int) {
        var prev:VariableEntry = null;

        for (entry in table) {
            if (entry.start < byteIndex && entry.end >= byteIndex) {
                if (prev == null) {
                    prev = entry;
                    continue;
                }

                if (entry.start >= prev.start && entry.end <= prev.end) {
                    prev = entry;
                }
            }
        }

        return prev == null ? null : prev.name;
    }

    public function fromByteCode(byteCode:BytesInput):VariableTable {
        final tableSize = byteCode.readInt32();
        final startPosition = byteCode.position;

        while (byteCode.position < startPosition + tableSize) {
            final start = byteCode.readInt32();
            final end = byteCode.readInt32();
            final nameLength = byteCode.readInt32();
            final name = byteCode.readString(nameLength);

            table.push({start: start, end: end, name: name});
        }

        return this;
    }
} 