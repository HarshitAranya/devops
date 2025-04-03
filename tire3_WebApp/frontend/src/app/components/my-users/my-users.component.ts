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
  
  userList: MyUser[] = []; // Ensure this is initialized

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.loadUsers();
  }

  loadUsers() {
    this.http.get<{ message: string, data: MyUser[] }>("/my-users")
      .subscribe(
        (userResult) => {
          console.log("API Response:", userResult); // Debugging API response
          this.userList = userResult.data; // Bind data to UI
        },
        (error) => {
          console.error("API Error:", error);
        }
      );
  }
  alertMsg: string = 'Before: This is from GET TS';
}
