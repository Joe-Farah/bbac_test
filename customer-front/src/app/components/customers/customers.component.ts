import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { FormsModule, ReactiveFormsModule, FormGroup, FormControl, Validators } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { CustomerService } from '../../services/customer.service';
import { Customer } from '../../model/customer.model';

@Component({
  selector: 'app-customers',
  standalone: true,
  imports: [
    CommonModule,
    MatTableModule,
    MatButtonModule,
    MatFormFieldModule,
    MatInputModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule
  ],
  templateUrl: './customers.component.html',
  styleUrls: ['./customers.component.scss']
})
export class CustomersComponent implements OnInit {
  displayedColumns: string[] = ['id', 'firstName', 'lastName', 'email', 'phone', 'dateOfBirth', 'addresses', 'creditCards'];
  dataSource: Customer[] = [];
  customerForm: FormGroup;
  nextId = 1;
  
  constructor(private customerService: CustomerService) {
    this.customerForm = new FormGroup({
      firstName: new FormControl('', Validators.required),
      lastName: new FormControl('', Validators.required),
      email: new FormControl('', [Validators.required, Validators.email]),
      phone: new FormControl('', Validators.required),
      dateOfBirth: new FormControl('', Validators.required)
    });
  }

  ngOnInit() {
    this.loadCustomers();
  }

  loadCustomers() {
    this.customerService.getCustomers().subscribe(customers => {
      this.dataSource = customers;
    });
  }

  addCustomer() {
    if (this.customerForm.valid) {
      const newCustomer: Customer = this.customerForm.value;
      
      this.customerService.addCustomer(newCustomer).subscribe(response => {
        this.dataSource = [...this.dataSource, response]; // Update table with API response
        this.customerForm.reset();
      }, error => {
        console.error('Error adding customer:', error);
      });
    }
  }
}
