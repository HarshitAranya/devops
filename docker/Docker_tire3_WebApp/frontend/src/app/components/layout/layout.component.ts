import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink, RouterOutlet } from '@angular/router';
import { DepartmentService } from '../../services/department.service';

@Component({
  selector: 'app-layout',
  standalone: true,
  imports: [RouterOutlet, RouterLink, FormsModule],
  templateUrl: './layout.component.html',
  styleUrl: './layout.component.css'
})
export class LayoutComponent {

  selectedRole: string = '';
  router = inject(Router);

  logOut(){
    localStorage.removeItem('loginUser');
    this.router.navigateByUrl('login')
  }

  loggedUserData: any;

  constructor(private deptService : DepartmentService){
    const loggedData = localStorage.getItem('loginUser');
    if(loggedData != null){
      this.loggedUserData = JSON.parse(loggedData);
      // alert(this.loggedUserData.emailId)
    }
  }

  onRoleChange(role:string){
    debugger;
    this.deptService.onRoleChange$.next(role);

    this.deptService.onRoleChg$.next(role);
    debugger;
  }

}
