import parser.Parser;
import sys.io.File;

class SnekkyD {

    public static function main() {
        final debug = Sys.args().contains("--debug");
        final code = File.getBytes(Sys.args()[0]);
        final parser = new Parser(code, debug);
        parser.parse();
    }
}