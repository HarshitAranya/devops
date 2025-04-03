import { Router } from '@angular/router';
import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {

  // userObj:any = {
  //   userName:'',
  //   Password:''
  // }

  userObj:any = {
    EmailId:'',
    Password:''
  }
  
  router = inject(Router);
  http = inject(HttpClient)

  // onClick(){
  //   debugger;
  //   if(this.userObj.EmailId == 'admin' && this.userObj.Password == "1234"){
  //     alert("Logged In");
  //     localStorage.setItem('loginUser', this.userObj.EmailId)
  //     this.router.navigateByUrl('add_emp');
  //   }else{
  //       debugger;
  //       alert("Login Failed");
  //   }
  //   debugger;
  // }
  
  onClick(){
    this.router.navigateByUrl('get-api'); // login bypass for testing
    // debugger;
    this.http.post("https://projectapi.gerasim.in/api/UserApp/login", this.userObj).subscribe( (res:any)=>{
      // debugger;
      if(res.result){
        // debugger;
        // alert("ok")
        localStorage.setItem('loginUser', this.userObj.EmailId)
        localStorage.setItem('loginUser', res.data)
        localStorage.setItem('loginUser', JSON.stringify(res.data))
        this.router.navigateByUrl('get-api');
      }else{
        // debugger;
        alert("error")
      }
      // debugger;
    })
  }

  
}
