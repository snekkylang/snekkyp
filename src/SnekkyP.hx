import haxe.crypto.Base64;
import haxe.io.Bytes;
import parser.Parser;

@:expose
class SnekkyP {

    public static function disassemble(byteCode:Bytes, debug:Bool) {
        final parser = new Parser(byteCode, debug);
        parser.parse();
        parser.print();
    }

    public static function fromBase64(code:String):Parser {
        final parser = new Parser(Base64.decode(code), true);
        parser.parse();

        return parser;
    }

    public static function main() {
        #if target.sys
        final debug = Sys.args().contains("--debug");
        final code = sys.io.File.getBytes(Sys.args()[0]);
        disassemble(code, debug);
        #end
    }
}