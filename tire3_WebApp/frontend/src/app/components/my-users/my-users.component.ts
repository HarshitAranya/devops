import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { MyUser } from '../../model/interface/IUser';
import { AlertComponent } from '../reusableComponent/alert/alert.component';


@Component({
  selector: 'app-my-users',
  standalone: true,
  imports: [AlertComponent],
  templateUrl: './my-users.component.html',
  styleUrl: './my-users.component.css'
})
export class MyUsersComponent {

  constructor(private http: HttpClient){
    this.nameOfthis(); // this should be there in this class
  }

    userList: MyUser [] = [];
    nameOfthis(){
      // debugger;
      // http://backend-web-app-service:4001/user   in case of cluster
      // http://backendapp:4001/user  in case of docker
      this.http.get<{ message: string, data: MyUser[] }>("http://backendapp:4001/user").subscribe((userResult)=>{
        // debugger;
        this.userList = userResult.data;
      })
    }

    alertMsg: string = 'Before: This is from GET TS';

}
