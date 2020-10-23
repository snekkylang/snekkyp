package object;

import haxe.ds.StringMap;

enum Object {
    Number(value:Float);
    String(value:String);
    UserFunction(position:Int, parametersCount:Int);
    BuiltInFunction(memberFunction:Array<Object>->Object, parametersCount:Int);
    Array(values:Array<Object>);
    Hash(values:StringMap<Object>);
    Null;
}