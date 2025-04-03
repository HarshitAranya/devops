export interface IUser {
    id:number,
    name:string,
    username:string,
    emailH:string,
}


export interface IDepartment {

    departmentId: number;
    departmentName: string;
    departmentLogo: string;
}
// , and ; both will work
export interface MyUser {
    id:number,
    fullname:string,
    email:string,
    mobile:string
}