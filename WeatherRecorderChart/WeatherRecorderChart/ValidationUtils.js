
    /*
        Various utility functions for input validation
    */

    /* utility functions to decide what value display in case of missing field value from DB */
    function getValueTodisplay(val) {

       if (val === undefined)
          return ""
       else
          return val;
    }

    /* Check if the provided value is empty. Return true if empty */
    function isEmptyValue(valueToCheck)
    {
        if (valueToCheck.length <= 0 )
           return true
        else
           return false;
    }

    /* check if the input value contains letters or invalid characters */
    function hasInvalidChar(fieldTxtValue) {
        return /[<>?%#;a-z*A-Z]|&#/.test(fieldTxtValue) ? true : false;
    }


