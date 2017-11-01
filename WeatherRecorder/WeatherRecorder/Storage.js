
/*
    Contains ALL the function used to manage the application database
*/

  /* See: http://doc.qt.io/archives/qt-5.5/qtquick-localstorage-qmlmodule.html for input arguments */
  function getDatabase() {
     return LocalStorage.openDatabaseSync("weatherRecorder_db", "1.0", "StorageDatabase", 1000000);
  }


  /* create the necessary tables.
     Note: with a column of type REAL for the saved value, is always used the comma as decimal separator also when user uses the dot sign */
  function createTables() {

      var db = getDatabase();

      db.transaction(
          function(tx) {
              tx.executeSql('CREATE TABLE IF NOT EXISTS configuration(id INTEGER PRIMARY KEY AUTOINCREMENT, param_name TEXT, param_value TEXT)');
              tx.executeSql('CREATE TABLE IF NOT EXISTS temperature(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, temperature_value REAL)');
      });
   }


  /* initialize the tables with some default values */
  function insertDefaultConfigValues(){

     insertConfigParamValue('city','Berlin');
     insertConfigParamValue('temperatureUnit','Celsius');
  }


  /* load the configuration parameter with the provided name */
  function getConfigParamValue(paramName){

        var db = getDatabase();
        var rs = "";
        db.transaction(function(tx) {
             rs = tx.executeSql('SELECT param_value FROM configuration WHERE param_name =?;',[paramName] );
            }
        );

        return rs.rows.item(0).param_value;
   }


   /* INSERT a configuration parameter value. Return "OK" if the updated row is made successfully, "ERROR" otherwise */
   function insertConfigParamValue(paramName,paramValue){

       var db = getDatabase();
       var res = "";

       db.transaction(function(tx) {

           var rs = tx.executeSql('INSERT INTO configuration (param_name, param_value) VALUES (?,?);', [paramName, paramValue]);
           if (rs.rowsAffected === 1) {
               res = "OK";
           } else {
               res = "Error";
           }
       }
       );
       return res;
   }



  /* UPDATE a configuration parameter value with the new provide one.
     Return "OK" if the updated row is made successfully, "ERROR" otherwise
  */
  function updateConfigParamValue(paramName,paramValue){

     var db = getDatabase();
     var res = "";

     db.transaction(function(tx) {
         var rs = tx.executeSql('UPDATE configuration SET param_value=? WHERE param_name=?;', [paramValue,paramName]);
         if (rs.rowsAffected === 1) {
             res = "OK";
         } else {
             res = "Error";
         }
     }
     );
     return res;
   }


   /* Return a temperature value for the given date. If misisng retun 'N/A' (i.e. not available) */
   function getTemperatureValueByDate(date){   

        var db = getDatabase();
        var targetDate = new Date (date);

        /* return a formatted date like: 2017-04-30 (yyyy-mm-dd) */
        var fullTargetDate = DateUtils.formatDateToString(targetDate);
        var rs = "";

        db.transaction(function(tx) {
              rs = tx.executeSql("SELECT temperature_value FROM temperature t where date(t.date) = date('"+fullTargetDate+"')");
            }
        );

        /* check if value is missing or not */
        if (rs.rows.length > 0) {            
            return rs.rows.item(0).temperature_value;
        } else {
            return "N/A";
        }
   }


  /* delete a temperature value for the given date */
  function deleteTemperatureByDate(date){

       var db = getDatabase();
       var targetDate = new Date (date);

       var fullTargetDate = DateUtils.formatDateToString(targetDate);
       var rs = "";

       db.transaction(function(tx) {
             rs = tx.executeSql("DELETE FROM temperature where date('"+fullTargetDate+"')");
           }
       );

       return rs.rowsAffected;
  }


  /* Insert a new temperature value for the given date */
  function insertTemperature(date,tempValue){      

       var db = getDatabase();
       var fullDate = new Date (date);
       var res = "";

       /* return a formatted date like: 2017-09-30 (yyyy-mm-dd) */
       var dateFormatted = DateUtils.formatDateToString(fullDate);

       db.transaction(function(tx) {

           var rs = tx.executeSql('INSERT INTO temperature (date, temperature_value) VALUES (?,?);', [dateFormatted, tempValue]);
           if (rs.rowsAffected > 0) {
               res = "OK";
           } else {
               res = "Error";
           }
       }
       );
       return res;
  }


  /* Update a temperature value for the given date. Return the amount of updated rows (0 in case of no updated row) */
  function updateTemperature(date,tempValue){

     var db = getDatabase();
     var fullDate = new Date (date);
     /* return a formatted date like: 2017-09-30 (yyyy-mm-dd) to be inserted in the database */
     var dateFormatted = DateUtils.formatDateToString(fullDate);

     var rs = "";

     db.transaction(function(tx) {
         rs = tx.executeSql('UPDATE temperature SET temperature_value=? WHERE date=?;', [tempValue,dateFormatted]);
        }
     );

     return rs.rowsAffected;
   }


   /* Remove ALL the saved Temperature values NOT the table (i.e.: the table will be empty).
      Return the number of rows deleted
   */
   function deleteAllTemperatureValues(){

       var db = getDatabase();
       var rs;

       db.transaction(function(tx) {
         rs = tx.executeSql('DELETE FROM temperature;');
        }
      );

      return rs.rowsAffected;
   }


