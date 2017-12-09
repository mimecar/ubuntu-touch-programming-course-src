

   /*
      NEW file added for chapter dedicated at QML and charts.
      Contains utility to retrieve data from the database and create the chart data-set
   */


   /* Get a reference to the SQLite database where pick-up the data */
   function getDatabase() {
       return LocalStorage.openDatabaseSync("weatherRecorderChart_db", "1.0", "StorageDatabase", 1000000);
   }

   /*
      Called to get the X Y dataSet for the chart
      Receive input Javascript date object about the target month range
   */
   function getChartData(fromDate, toDate){

       /* the amount of days for the target month (eg: 30) */
       var monthDays = DateUtils.getDifferenceInDays(fromDate,toDate);

       var xyDataSet = prepareEmptyDataset(fromDate,monthDays);

       updateXYdataset(fromDate,toDate,xyDataSet);

       /* enable only for debug: print the XY data-set
          printDataSet(xyDataSet);
       */

       /* extract single x,y dataset */
       var x = getXaxisValue(xyDataSet);
       var y = getYaxisValue(xyDataSet);

       var ChartBarData = {
               labels: x,
               datasets: [{
                      fillColor: "rgba(220,220,220,0.5)",
                      strokeColor: "rgba(220,220,220,1)",
                      data: y
                  }
               ]
        }

       getChartLegendData(xyDataSet);

       return ChartBarData;
    }

    /* Extract the X values from the full XY data-set. X values are the 'key' part of the full XY data-set
       (i.e. the date yyyy-mm-dd)
    */
    function getXaxisValue(xyDataSet){
        var x = [];

        for(var key in xyDataSet) {            
            x.push(key);
        }

        return x;
    }

    /* Extract the Y values from the full XY data-set. Y values are the 'value' part of the full XY data-set
       (i.e. the temperature value)
    */
    function getYaxisValue(xyDataSet){
        var y = [];

        for(var key in xyDataSet) {            
            y.push(xyDataSet[key]);
        }

        return y;
    }

    /* DEBUG function to print to console the XY chart dataSet */
    function printDataSet(xyDataSet){

       for(var key in xyDataSet) {
           console.log("Key: "+key+ " value:"+ xyDataSet[key]);
       }
    }

    /*
      Prepare an XY data-set for each day in the target month, setting his temperature value to zero
      (default value).
      'fromDate'  the first day of the target month (ie. the first X value of the chart)
      'monthDays' the number of day of the target month (e.g. 28 - 31)
    */
    function prepareEmptyDataset(fromDate, monthDays){

        /* Init an empty associative array */
        var xyDataSet = {};

        for(var i=0;i < monthDays+1; i++) {
            /* initialize to zero the temparature value for the date */
            xyDataSet[DateUtils.addDaysAndFormat(fromDate, i)] = 0;
        }

        return xyDataSet;
    }

    /*
      Extract from the Database the temperarture values inside the target month and update the
      provided XY dataset setting replacing the default value (ie. zero) with the right temperature value for the day.
    */
    function updateXYdataset(fromDate, toDate, xyDataSet){

          var dateTo = DateUtils.formatDateToString(toDate);
          var dateFrom = DateUtils.formatDateToString(fromDate);

          var db = getDatabase();
          var rs = "";

          db.transaction(function(tx) {
               rs = tx.executeSql("select temperature_value,date from temperature e where date(e.date) <= date('"+dateTo+"') and date(e.date) >= date('"+dateFrom+"') order by date asc");
             }
          );

          /* update the values in the xy dataSet previously initialize to zero with the one coming from the Database */
          for(var i =0;i < rs.rows.length;i++)
          {
             xyDataSet[rs.rows.item(i).date] = rs.rows.item(i).temperature_value
          }         
    }

    /* Fill the QML ListModel used to create the Chart legend. The values inserted will be shown
       by a Listview component
    */
    function getChartLegendData(xyDataSet){

        customRangeChartListModel.clear();

        for(var key in xyDataSet) {
           customRangeChartListModel.append({"date": key,"temp":xyDataSet[key]});
        }
    }
