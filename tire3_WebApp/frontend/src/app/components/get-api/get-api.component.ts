import { HttpClient, provideHttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { AlertComponent } from '../reusableComponent/alert/alert.component';
import { Customer } from '../../model/class/Customer';
import { IUser } from '../../model/interface/IUser';

@Component({
  selector: 'app-get-api',
  standalone: true,
  imports: [AlertComponent],
  templateUrl: './get-api.component.html',
  styleUrl: './get-api.component.css'
})
export class GetApiComponent {

  constructor(private http: HttpClient){
    this.getAllUsers();
  }

  // userList: any [] = [];
  userList: IUser [] = [];
  getAllUsers(){
    // debugger;
    this.http.get("https://jsonplaceholder.typicode.com/users").subscribe((userResult:any)=>{
      // debugger;
      this.userList = userResult;
    })
  }

  // for this use ng s --port 4209
  // customerList: any [] = [];
  customerList: Customer [] = [];
  // getAllCustomer(){
  //   this.http.get("https://projectapi.gerasim.in/api/RealEstate/GetAllCustomers").subscribe(
  //     (res:any)=>{
  //       // debugger;
  //       this.customerList = res.data;
  //     }, error=>{
  //       debugger;
  //     })
  // }

  getAllCustomer(){
    this.http.get("https://projectapi.gerasim.in/api/PropertyBookingController/GetAllCustomer").subscribe(
      (res:any)=>{
        // debugger;
        this.customerList = res.data;
      }, error=>{
        debugger;
      })
  }

  alertMsg: string = 'Before: This is from GET TS';

  changedMsg(){
    debugger;
    this.alertMsg = 'After: This is from GET TS';
  }
}
