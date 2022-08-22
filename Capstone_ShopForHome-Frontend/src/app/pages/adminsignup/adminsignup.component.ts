import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { admin } from 'src/app/models/admin';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-adminsignup',
  templateUrl: './adminsignup.component.html',
  styleUrls: ['./adminsignup.component.css']
})
export class AdminsignupComponent implements OnInit {

  admin:admin;
  constructor(
    private userService: UserService,
    private router: Router) { 
      this.admin=new admin();
    }


    registerForm = new FormGroup(
      {
        email: new FormControl('', [Validators.required, Validators.email, Validators.pattern("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+(com|in)$")]),
        name: new FormControl('', [Validators.required, Validators.minLength(3),Validators.pattern('^[a-zA-Z]+$')]),
        password: new FormControl('', [
          Validators.required,
          Validators.minLength(8),
          Validators.pattern('^[a-zA-Z0-9!@#$%^&*]+$')
        ]),
        phone: new FormControl('', [Validators.required, Validators.minLength(10), Validators.pattern("^\\d{10}$")]),
        address: new FormControl('', [Validators.required]),
  
      }
  
      
    );

  ngOnInit() {
  }
  get f() {
    return this.registerForm.controls;
  }
  onSubmit() {
    this.admin.email = this.registerForm.value.email
    this.admin.name = this.registerForm.value.name
    this.admin.password = this.registerForm.value.password
    this.admin.phone = this.registerForm.value.phone
    this.admin.address = this.registerForm.value.address
    this.userService.signUp(this.admin).subscribe(u => {
      this.router.navigate(['/login']);
    },
        e => {});
  }
}