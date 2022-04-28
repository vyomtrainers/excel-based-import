/**
 * @description       : 
 * @author            : Yogesh.Bhosale
 * @group             : 
 * @last modified on  : 11-28-2021
 * @last modified by  : Yogesh.Bhosale
**/
public with sharing class FileProcessor {

    /**
     * Process File Interacing the UI 
     * 
     */
     public static String processFile(String fileName, String recordData, String filterCriteria ) {
        String result = '';
        IFileProcessor processor = getFileProcessor(fileName);
        if (processor != null ) {
            result = processor.processFile(recordData , filterCriteria);
            if( result == null) {
                Log.debug('Could not Process file :'+fileName);
            }
        }else{
            Log.debug('Processor Not Available for  :' + fileName);
        }
        return result;
    }

    /**
     * Get the processor based on file names
     * 
     */
    private static IFileProcessor getFileProcessor(String fileName) {
        IFileProcessor processor = null;

        String extension = getFileExtension(fileName);
        Log.debug( 'extension for  '+fileName + ' is '+extension); 

        if( isExcelExtension(extension)){
            Log.debug( 'Found Processor For '+fileName + ' preparing Processor'); 
            processor = new ExcelFileProcessor(fileName);
            
        } else {
            Log.debug('Extension do not Found ');   
        }
        return processor;
    }

    private static String getFileExtension(String fileName){
        String strExtension = fileName.substringAfterLast('.');
        return strExtension;
    }

    private static Boolean isExcelExtension(String extension){
        extension  = extension.isNumeric() ?extension :extension.toUpperCase();
        Boolean isExcel = false ;
        List<String> excelExtension = new List<String>();
        excelExtension.add('XLS');
        excelExtension.add('XLSX');
        excelExtension.add('XLSB');
        return excelExtension.contains(extension);

    }
}
