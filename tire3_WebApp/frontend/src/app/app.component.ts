import { Component } from '@angular/core';
import { RouterLink, RouterOutlet } from '@angular/router';
// import { AddEmployeeComponent } from './components/add-employee/add-employee.component';
// import { EmployeeListComponent } from './components/employee-list/employee-list.component';
// import { DataBindingComponent } from './components/data-binding/data-binding.component';
// import { DirectiveComponent } from "./components/directive/directive.component";
// import { AttributeDirectiveComponent } from './components/attribute-directive/attribute-directive.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, RouterLink
    // , DataBindingComponent 
    // , DirectiveComponent
    // , AttributeDirectiveComponent
    // , AddEmployeeComponent
    // , EmployeeListComponent
    // , EmployeeListComponent
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'angular18';
}
