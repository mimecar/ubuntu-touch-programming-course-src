
/*
    Various utility functions for input validation
*/

    /* Check if the provided value is empty. Return true if empty */
    function isEmptyValue(valueToCheck)
    {
        if (valueToCheck.length <= 0 )
           return true
        else
           return false;
    }

    /* check if the input value contains letters or invalid characters (i.e. is not numeric) */
    function hasInvalidChar(fieldTxtValue) {
        return /[<>?%#;a-z*A-Z]|&#/.test(fieldTxtValue) ? true : false;
    }


