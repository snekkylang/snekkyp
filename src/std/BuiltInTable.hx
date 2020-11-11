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
        "File",
        "Http",
        "Thread"
    ]; 

    public static function resolveName(index:Int):String {
        return namespaces[index];
    }
}