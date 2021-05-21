package code.debug;

import haxe.io.BytesInput;

private typedef FilenameEntry = {start:Int, end:Int, fileName:String};

class FilenameTable {

    final table:Array<FilenameEntry> = [];

    public function new() {}

    public function define(start:Int, end:Int, fileName:String) {
        table.push({start: start, end: end, fileName: fileName});
    }

    public function resolve(byteIndex:Int):String {
        var prev:FilenameEntry = null;

        for (entry in table) {
            if (entry.start <= byteIndex && entry.end >= byteIndex) {
                if (prev == null) {
                    prev = entry;
                    continue;
                }

                if (entry.start >= prev.start && entry.end <= prev.end) {
                    prev = entry;
                }
            }
        }

        return prev == null ? null : prev.fileName;
    }

    public function fromByteCode(byteCode:BytesInput):FilenameTable {
        final tableSize = byteCode.readInt32();
        final startPosition = byteCode.position;

        while (byteCode.position < startPosition + tableSize) {
            final start = byteCode.readInt32();
            final end = byteCode.readInt32();
            final fileNameLength = byteCode.readInt32();
            final fileName = byteCode.readString(fileNameLength);

            table.push({start: start, end: end, fileName: fileName});
        }

        return this;
    }
}