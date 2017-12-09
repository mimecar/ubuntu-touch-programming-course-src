
/* Utility to work with dates in Javascript */


/* Format input date to have double digits for day and month (default is one digit in js)
   Example: return date like: YYYY-MM-DD
   eg: 2017-04-28
*/
function formatDateToString(date)
{
   var dd = (date.getDate() < 10 ? '0' : '') + date.getDate();
   var MM = ((date.getMonth() + 1) < 10 ? '0' : '') + (date.getMonth() + 1);
   var yyyy = date.getFullYear();

   return (yyyy + "-" + MM + "-" + dd);
}

/*
  Calculates the difference in days between the two dates in argument
*/
function getDifferenceInDays(dateFrom, dateTo){

    //Get 1 day in milliseconds
    var one_day = 1000*60*60*24;

    var date1_ms = dateFrom.getTime();
    var date2_ms = dateTo.getTime();

    // Calculate the difference in milliseconds
    var difference_ms = date2_ms - date1_ms;

    // Convert back to days and return
    return Math.round(difference_ms/one_day);
}



/* Add the provided amount of days at the input date, if amount is negative, subtract them.
   The returned data has pattern YYYY-MM-DD
 */
function addDaysAndFormat(date, days) {

        var newDate = new Date(
            date.getFullYear(),
            date.getMonth(),
            date.getDate() + days,
            0,
            0,
            0,
            0
        );

    return formatDateToString(newDate);
}




