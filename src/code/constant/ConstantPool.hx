package code.constant;

import object.Object;
import haxe.io.BytesInput;

class ConstantPool {

    public static function fromByteCode(byteCode:BytesInput):Array<Object> {
        final pool:Array<Object> = [];
        final poolSize = byteCode.readInt32();
        final startPosition = byteCode.position;

        while (byteCode.position < startPosition + poolSize) {
            final type = byteCode.readByte();

            switch (type) {
                case ConstantType.Float:
                    final value = byteCode.readDouble();
                    pool.push(Object.Number(value));
                case ConstantType.String:
                    final length = byteCode.readInt32();
                    final value = byteCode.readString(length);
                    pool.push(Object.String(value));
                case ConstantType.UserFunction:
                    final position = byteCode.readInt32();
                    final parametersCount = byteCode.readInt16();
                    pool.push(Object.UserFunction(position, parametersCount));
                case ConstantType.Null:
                    pool.push(Object.Null);
                case ConstantType.Boolean:
                    final value = byteCode.readByte();
                    pool.push(Object.Boolean(value != 0));
                default:
            }    
        }

        return pool;
    }
}