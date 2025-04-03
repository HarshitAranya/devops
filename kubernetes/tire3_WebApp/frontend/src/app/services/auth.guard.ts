import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

export const authGuard: CanActivateFn = (route, state) => {

  const router = inject(Router);
  const localUser = localStorage.getItem('loginUser');
  // debugger;
  // if(localUser != null){
  if(localUser == null){
    // debugger;
    return true;
    
  }else{
    // debugger;
    return true; //bypass for testing
    router.navigateByUrl('login');
    // return false;
  }
  
};
