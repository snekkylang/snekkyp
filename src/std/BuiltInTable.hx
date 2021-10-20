package std;

class BuiltInTable {

    static final namespaces = [
        "Sys",
        "Math",
        "Number",
        "Object",
        "Range",
        "Regex",
        "Json",
        "Io",
        "String",
        "EventLoop",
        "File",
        "Http",
        "Net"
    ]; 

    public static function resolveName(index:Int):String {
        return namespaces[index];
    }
}