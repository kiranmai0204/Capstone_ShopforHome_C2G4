import {
    AbstractControl,
    ValidatorFn,
    FormControl,
    FormGroup
  } from '@angular/forms';
  
  export class CustomValidators {
    constructor() {}
  
    static onlyChar(): ValidatorFn {
      return (control: AbstractControl): { [key: string]: boolean } | null => {
        if (control.value == '') return null;
  
        let re = new RegExp('^[a-zA-Z]*$');
        if (re.test(control.value)) {
          return null;
        } else {
          return { onlyChar: true };
        }
      };
    }
    
  }