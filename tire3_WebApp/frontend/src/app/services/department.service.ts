import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DepartmentService {

  onRoleChange$ : Subject<string> = new Subject<string>;
  onRoleChg$ : BehaviorSubject<string> = new BehaviorSubject<string>("");

  apiURL: string = "https://projectapi.gerasim.in/api/Complaint/";

  constructor(private http:HttpClient) { }


  deleteDep(id:number){
    return this.http.delete("https://projectapi.gerasim.in/api/Complaint/DeletedepartmentBydepartmentId?departmentId="+ id);
  }

  addTwoNum(num1: number, num2: number){
    return num1 + num2;
  }
}
