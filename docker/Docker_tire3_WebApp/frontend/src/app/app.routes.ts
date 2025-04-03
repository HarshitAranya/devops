
import { Routes } from '@angular/router';
import { GetApiComponent } from './components/get-api/get-api.component';
import { PostApiComponent } from './components/post-api/post-api.component';
import { LoginComponent } from './components/login/login.component';
import { LayoutComponent } from './components/layout/layout.component';
import { authGuard } from './services/auth.guard';
import { MyUsersComponent } from './components/my-users/my-users.component';

export const routes: Routes = [
    // default route
    {
        path:'',
        redirectTo:'login',
        pathMatch:'full'
    },
    {
        path:'login',
        component:LoginComponent
    },
    {
        path:'',
        component:LayoutComponent,
        canActivate:[authGuard],
        children:[

            {
                path: 'get-api',
                component: GetApiComponent
            },
            {
                path: 'my-users',
                component: MyUsersComponent
            },
            {
                path: 'post-api',
                component: PostApiComponent
            }

        ]
    }

];
