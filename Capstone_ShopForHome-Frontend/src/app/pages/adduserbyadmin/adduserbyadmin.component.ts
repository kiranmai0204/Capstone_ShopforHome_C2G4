import {Component, OnInit} from '@angular/core';
import {Location} from '@angular/common';
import {User} from "../../models/User";
import {UserService} from "../../services/user.service";
import {Router} from "@angular/router";
@Component({
  selector: 'app-adduserbyadmin',
  templateUrl: './adduserbyadmin.component.html',
  styleUrls: ['./adduserbyadmin.component.css']
})
export class AdduserbyadminComponent implements OnInit {
  user: User;
  constructor( private location: Location,
    private userService: UserService,
    private router: Router) {
this.user = new User();

}

  ngOnInit() {
  }

  onSubmit() {
    this.userService.signUp(this.user).subscribe(u => {
      alert("User added successfully");
      this.router.navigate(['/admin/user']);
    },
        e => {});
  }
}
