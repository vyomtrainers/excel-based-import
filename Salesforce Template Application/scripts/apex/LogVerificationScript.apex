LogUitility.debug('Hi there');
Log.debug('Just to check if it Works ');

List<Object> values = new List<Object>();
values.add('Yogesh');
values.add('Inteligent');
LogUitility.debug('Here is {0} and I am Not {1} ' , values);


String fileName ='abc.sdsd.xls';
String ext = fileName.substringAfterLast('.');
System.debug(ext);


 String result = FileProcessor.processFile('abc.xls' ,'null', 'Account' );
 System.debug(result);