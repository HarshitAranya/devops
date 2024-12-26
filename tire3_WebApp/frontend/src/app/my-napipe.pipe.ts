import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'myNApipe',
  standalone: true
})
export class MyNApipePipe implements PipeTransform {

  transform(value: unknown, ...args: unknown[]): unknown {
    if(value !== null && value !==undefined && value !== ''){
      return value;
    }else{
      return 'NA';
    }
  }

}
