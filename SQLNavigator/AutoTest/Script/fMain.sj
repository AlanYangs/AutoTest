//USEUNIT fCommFun
//USEUNIT fMSIInstaller
//USEUNIT fLogon
//USEUNIT Menu_File
//USEUNIT Menu_Edit
//USEUNIT Menu_Search
//USEUNIT Menu_View
//USEUNIT Menu_Session
//USEUNIT Menu_Object
//USEUNIT Menu_Tools
//USEUNIT Menu_Window
//USEUNIT Menu_Help
//USEUNIT Toolbox_DBExplorer
//USEUNIT Toolbox_History
//USEUNIT CodeEditor_Syntax
//USEUNIT CodeEditor_ExportData

function main(){
    //MSIInstaller();
    logon(false);
    traverseFileMenu();
    traverseEditMenu();
    traverseSearchMenu();
    traverseViewMenu();
    traverseSessionMenu();
    traverseObjectMenu();
    traverseToolsMenu();
    traverseWindowMenu();
    traverseHelpMenu();
    /*****Code Editor*****/
    checkDBExplorer();
    checkHistory();
    checkCodeEditorSyntax();
    checkExportData();
    closeSqlnavigator();
}
