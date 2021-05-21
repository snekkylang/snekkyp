package parser;

import std.BuiltInTable;
import instruction.*;
import code.OpCode;
import object.Object;
import code.constant.ConstantPool;
import code.debug.VariableTable;
import code.debug.LineNumberTable;
import code.debug.FilenameTable;
import haxe.zip.Uncompress;
import haxe.io.Bytes;
import haxe.io.BytesInput;

class Parser {

    final debug:Bool;
    final fileNameTable:FilenameTable;
    final lineNumberTable:LineNumberTable;
    final variableTable:VariableTable;
    final constantPool:Array<Object>;
    final instructions:BytesInput;
    final parsedInstructions:Array<Instruction> = [];

    public function new(fileData:Bytes, debug:Bool) {
        final fileData = new BytesInput(fileData);
        final byteCode = if (fileData.readByte() == 1) {
            new BytesInput(Uncompress.run(fileData.readAll()));
        } else {
            new BytesInput(fileData.readAll());
        }
        fileNameTable = new FilenameTable().fromByteCode(byteCode);
        lineNumberTable = new LineNumberTable().fromByteCode(byteCode);
        variableTable = new VariableTable().fromByteCode(byteCode);
        constantPool = ConstantPool.fromByteCode(byteCode);
        instructions = new BytesInput(byteCode.read(byteCode.readInt32()));

        this.debug = debug;
    }

    public function parse() {
        while (instructions.position < instructions.length) {
            parseInstruction();
        }
    }

    public function print() {
        for (ins in getInstructionsAsStrings()) {
            println(ins);
        }
    }

    public function getInstructions(fileName:String = null) {
        return parsedInstructions.filter(ins -> fileName == null || ins.info.fileName == fileName);
    }

    public function getInstructionsAsStrings(fileName:String = null) {
        final relevantInstructions = getInstructions(fileName);

        final instructionStrings:Array<String> = [];

        final insCountMaxLength = Std.string(relevantInstructions.length).length;
        final posCountMaxLength = Std.string(instructions.length).length;
        var fileInfoMaxLength = 0;

        if (debug) {
            for (ins in relevantInstructions) {
                if (ins.info.fileName.length > fileInfoMaxLength) {
                    fileInfoMaxLength = ins.info.fileName.length;
                }
            }
        }

        for (i => ins in relevantInstructions) {
            final insCount = StringTools.lpad(Std.string(i), "0", insCountMaxLength);
            final info = new StringBuf();
            info.add(insCount);
            info.add(" | ");
            info.add(StringTools.lpad(Std.string(ins.info.bytePosition), "0", posCountMaxLength));
            info.add(" | ");
            if (debug) {
                info.add(StringTools.rpad(ins.info.fileName, " ", fileInfoMaxLength));
                info.add(" | ");
            }
            instructionStrings.push('$info$ins');
        }

        return instructionStrings;
    }

    inline function println(message:String) {
        #if target.sys
        Sys.println(message);
        #else
        js.Browser.console.log(message);
        #end
    }

    function parseInstruction() {
        final opCode = instructions.readByte();

        final lineInfo = lineNumberTable.resolve(instructions.position);
        final info = {
            bytePosition: instructions.position,
            fileName: fileNameTable.resolve(instructions.position),
            line: lineInfo.line,
            linePos: lineInfo.linePos
        };

        final instruction = switch (opCode) {
            case OpCode.Constant:
                final index = instructions.readInt32();
                final value = constantPool[index];

                new ConstantIns(index, value, info);
            case OpCode.Pop:
                new PopIns(info);
            case OpCode.Jump:
                final index = instructions.readInt32();

                new JumpIns(index, info);
            case OpCode.JumpNot:
                final index = instructions.readInt32();

                new JumpNotIns(index, info);
            case OpCode.JumpPeek:
                final index = instructions.readInt32();

                new JumpPeekIns(index, info);
            case OpCode.Add: new AddIns(info);
            case OpCode.Subtract: new SubtractIns(info);
            case OpCode.Multiply: new MultiplyIns(info);
            case OpCode.Divide: new DivideIns(info);
            case OpCode.BitAnd: new BitAndIns(info);
            case OpCode.BitOr: new BitOrIns(info);
            case OpCode.BitXor: new BitXorIns(info);
            case OpCode.BitShiftLeft: new BitShiftLeftIns(info);
            case OpCode.BitShiftRight: new BitShiftRightIns(info);
            case OpCode.BitNot: new BitNotIns(info);
            case OpCode.Modulo: new ModuloIns(info);
            case OpCode.Equals: new EqualsIns(info);
            case OpCode.LessThan: new LessThanIns(info);
            case OpCode.LessThanOrEqual: new LessThanOrEqualIns(info);
            case OpCode.GreaterThan: new GreaterThanIns(info);
            case OpCode.GreaterThanOrEqual: new GreaterThanOrEqualIns(info);
            case OpCode.Negate: new NegateIns(info);
            case OpCode.Not: new NotIns(info);
            case OpCode.ConcatString: new ConcatStringIns(info);
            case OpCode.Load:
                final index = instructions.readInt32();
                final name = variableTable.resolveIndex(index);

                new LoadIns(index, name, info);
            case OpCode.Store:
                final index = instructions.readInt32();
                var name = variableTable.resolveIndex(index);

                new StoreIns(index, name, info);
            case OpCode.LoadBuiltIn:
                final index = instructions.readInt32();
                final name = BuiltInTable.resolveName(index);

                new LoadBuiltInIns(index, name, info);
            case OpCode.Call:
                final parametersCount = instructions.readInt32();

                new CallIns(parametersCount, info);
            case OpCode.Return: new ReturnIns(info);
            case OpCode.Array:
                final size = instructions.readInt32();

                new ArrayIns(size, info);
            case OpCode.Hash:
                final size = instructions.readInt32();

                new HashIns(size, info);
            case OpCode.LoadIndex: new LoadIndexIns(info);
            case OpCode.StoreIndex: new StoreIndexIns(info);
            default: trace('Unknown OpCode `$opCode`'); new Instruction("unknown", info);
        }

        parsedInstructions.push(instruction);
    }
}