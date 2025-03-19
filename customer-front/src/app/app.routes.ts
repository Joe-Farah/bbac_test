import { Routes } from '@angular/router';
import { CustomersComponent } from './components/customers/customers.component';

export const routes: Routes = [
  { path: '', redirectTo: 'customers', pathMatch: 'full' },
  { path: 'customers', component: CustomersComponent }
];
