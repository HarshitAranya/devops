import { JsonPipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, inject, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DepartmentService } from '../../services/department.service';
import { AlertComponent } from '../reusableComponent/alert/alert.component';
import { MyButtonComponent } from '../reusableComponent/my-button/my-button.component';
import { Department } from '../../model/class/Customer';
import { IDepartment } from '../../model/interface/IUser';

@Component({
  selector: 'app-post-api',
  standalone: true,
  imports: [FormsModule, AlertComponent, MyButtonComponent ],
  templateUrl: './post-api.component.html',
  styleUrl: './post-api.component.css'
})
export class PostApiComponent {
  // depObj: any = {
  //   "departmentId": 0,
  //   "departmentName": "",
  //   "departmentLogo": ""
  // }

  depObj: Department = new Department();


  result1: number;
  // One way
  http = inject(HttpClient);
  // second way
  constructor(private depSrv:DepartmentService){
    this.result1 = this.depSrv.addTwoNum(2, 3);
  }
  
  onSave(){
    // debugger;
    // this.http.post("https://projectapi.gerasim.in/api/Complaint/AddNewDepartment", this.depObj).subscribe(
    // (res: any)=>{
    //   debugger;
    //   if(res.result){
    //     debugger;
    //     alert("Department is created" + res.message)
    //     this.getDepa();
    //   }else{alert(res.result + res.message)}
    // })

  }

  // depaList:any [] = [];
  depaList:IDepartment [] = [];

  onEdit(data:any){
    this.depObj = new Department();
    this.depObj = data;
  }

  myButtonData: string = '';
  getData(data:any){
    debugger;
    this.myButtonData = data;
  }

}
