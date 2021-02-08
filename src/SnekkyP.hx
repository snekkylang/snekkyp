import haxe.io.Bytes;
import parser.Parser;

@:expose
class SnekkyP {

    public static function disassemble(byteCode:Bytes, debug:Bool) {
        final parser = new Parser(byteCode, debug);
        parser.parse();   
    }

    public static function main() {
        #if target.sys
        final debug = Sys.args().contains("--debug");
        final code = sys.io.File.getBytes(Sys.args()[0]);
        disassemble(code, debug);
        #end
    }
}