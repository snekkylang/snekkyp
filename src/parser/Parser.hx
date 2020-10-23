package parser;

import std.BuiltInTable;
import instruction.*;
import code.OpCode;
import object.Object;
import code.constant.ConstantPool;
import code.debug.LocalVariableTable;
import code.debug.LineNumberTable;
import code.debug.FilenameTable;
import haxe.zip.Uncompress;
import haxe.io.Bytes;
import haxe.io.BytesInput;

class Parser {

    final debug:Bool;
    final filenameTable:FilenameTable;
    final lineNumberTable:LineNumberTable;
    final localVariableTable:LocalVariableTable;
    final constantPool:Array<Object>;
    final instructions:BytesInput;
    final parsedInstructions:Array<Instruction> = [];
    final variableNames:Array<String> = [];
    final fileInfo:Array<String> = [];

    public function new(fileData:Bytes, debug:Bool) {
        final fileData = new BytesInput(fileData);
        final byteCode = if (fileData.readByte() == 1) {
            new BytesInput(Uncompress.run(fileData.readAll()));
        } else {
            new BytesInput(fileData.readAll());
        }
        filenameTable = new FilenameTable().fromByteCode(byteCode);
        lineNumberTable = new LineNumberTable().fromByteCode(byteCode);
        localVariableTable = new LocalVariableTable().fromByteCode(byteCode);
        constantPool = ConstantPool.fromByteCode(byteCode);
        instructions = new BytesInput(byteCode.read(byteCode.readInt32()));

        this.debug = debug;
    }

    public function parse() {
        while (instructions.position < instructions.length) {
            parseInstruction();
        }

        final insCountMaxLength = Std.string(parsedInstructions.length).length;
        final posCountMaxLength = Std.string(instructions.length).length;
        var fileInfoMaxLength = 0;
        for (s in fileInfo) {
            if (s.length > fileInfoMaxLength) {
                fileInfoMaxLength = s.length;
            }
        }

        for (i => ins in parsedInstructions) {
            final insCount = StringTools.lpad(Std.string(i), "0", insCountMaxLength);
            Sys.print(insCount);
            Sys.print(" | ");
            Sys.print(StringTools.lpad(Std.string(ins.bytePosition), "0", posCountMaxLength));
            Sys.print(" | ");
            if (debug) {
                Sys.print(StringTools.rpad(fileInfo[i], " ", fileInfoMaxLength));
                Sys.print(" | ");
            }
            Sys.println(ins);
        }
    }

    function parseInstruction() {
        final position = instructions.position;
        final opCode = instructions.readByte();

        if (debug) {
            final position = lineNumberTable.resolve(instructions.position);
            final filename = filenameTable.resolve(instructions.position);
            fileInfo.push('$filename:${position.line}:${position.linePos + 1}');
        }

        final instruction = switch (opCode) {
            case OpCode.Constant:
                final index = instructions.readInt32();
                final value = constantPool[index];

                new ConstantIns(index, value, position);
            case OpCode.Pop:
                new PopIns(position);
            case OpCode.Jump:
                final index = instructions.readInt32();

                new JumpIns(index, position);
            case OpCode.JumpNot:
                final index = instructions.readInt32();

                new JumpNotIns(index, position);
            case OpCode.JumpPeek:
                final index = instructions.readInt32();

                new JumpPeekIns(index, position);
            case OpCode.Add: new AddIns(position);
            case OpCode.Subtract: new SubtractIns(position);
            case OpCode.Multiply: new MultiplyIns(position);
            case OpCode.Divide: new DivideIns(position);
            case OpCode.Modulo: new ModuloIns(position);
            case OpCode.Equals: new EqualsIns(position);
            case OpCode.LessThan: new LessThanIns(position);
            case OpCode.GreaterThan: new GreaterThanIns(position);
            case OpCode.Negate: new NegateIns(position);
            case OpCode.Not: new NotIns(position);
            case OpCode.ConcatString: new ConcatStringIns(position);
            case OpCode.Load:
                final index = instructions.readInt32();

                new LoadIns(index, position);
            case OpCode.Store:
                final index = instructions.readInt32();

                new StoreIns(index, position);
            case OpCode.LoadBuiltIn:
                final index = instructions.readInt32();
                final name = BuiltInTable.resolveName(index);

                new LoadBuiltInIns(index, name, position);
            case OpCode.Call:
                final parametersCount = instructions.readInt32();

                new CallIns(parametersCount, position);
            case OpCode.Return: new ReturnIns(position);
            case OpCode.Array:
                final size = instructions.readInt32();

                new ArrayIns(size, position);
            case OpCode.Hash:
                final size = instructions.readInt32();

                new HashIns(size, position);
            case OpCode.LoadIndex: new LoadIndexIns(position);
            case OpCode.StoreIndex: new StoreIndexIns(position);
            case OpCode.DestructureArray: 
                final index = instructions.readInt32();
                new DestructureArrayIns(index, position);
            case OpCode.DestructureHash: new DestructureHashIns(position);

            default: trace('Unknown OpCode `$opCode`'); new Instruction("unknown", position);
        }

        parsedInstructions.push(instruction);
    }
}