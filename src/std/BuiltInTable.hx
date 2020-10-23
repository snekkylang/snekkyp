package std;

class BuiltInTable {

    static final namespaces = [
        "Sys",
        "Math",
        "String",
        "File",
        "Http"
    ]; 

    public static function resolveName(index:Int):String {
        return namespaces[index];
    }
}