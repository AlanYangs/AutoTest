//USEUNIT fCommFun
//USEUNIT vGlobalVariables

function test(){
    var str = "|All Projects|Project2";
    Log.Message(str.lastIndexOf("|"));
    eval(null);
    var i = 0;
    Log.Message(i++);
    Log.Message(i);
    if(aqFile.Exists("C:\\Users\\ayang1\\AppData\\Roaming\\Dell\\SQL Navigator 7.3.0 Beta\\AutoTest_SupportBundle.dta")){
            Log.Message("Success to create a new Support Bundle file in: AutoTest_SupportBundle.dta");
        }
}
