import {Component, OnDestroy, OnInit} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {OrderService} from "../../services/order.service";
import {Order} from "../../models/Order";
import {OrderStatus} from "../../enum/OrderStatus";
import {UserService} from "../../services/user.service";
import {JwtResponse} from "../../response/JwtResponse";
import {Subscription} from "rxjs";
import {ActivatedRoute} from "@angular/router";
import {Role} from "../../enum/Role";
import { ExcelService } from 'src/app/services/ExcelService';
// import * as moment from 'moment';

@Component({
    selector: 'app-order',
    templateUrl: './order.component.html',
    styleUrls: ['./order.component.css']
})
export class OrderComponent implements OnInit, OnDestroy {

    page: any;
    OrderStatus = OrderStatus;
    currentUser: JwtResponse;
    Role = Role;
    selectedDate: any='';
    
    
    constructor(private httpClient: HttpClient,
                private orderService: OrderService,
                private userService: UserService,
                private route: ActivatedRoute,
                private excelService: ExcelService
    ) {
    }

    querySub: Subscription;

    ngOnInit() {
        this.currentUser = this.userService.currentUserValue;
        this.querySub = this.route.queryParams.subscribe(() => {
            this.update();
        });
    
    }

    update() {
        let nextPage = 1;
        let size = 10;
        if (this.route.snapshot.queryParamMap.get('page')) {
            nextPage = +this.route.snapshot.queryParamMap.get('page');
            size = +this.route.snapshot.queryParamMap.get('size');
        }
        this.orderService.getPage(nextPage, size).subscribe(page => this.page = page, _ => {
            console.log("Get Order Failed")
        });
    }

    exportAsXLSX():void{
        let nextPage = 1;
        let size = 10;
        this.orderService.getPage(nextPage, size).subscribe(response => this.excelService.exportAsExcelFile(response.content,"Report"));
        
}


    cancel(order: Order) {
        this.orderService.cancel(order.orderId).subscribe(res => {
            if (res) {
                order.orderStatus = res.orderStatus;
            }
        });
    }

    finish(order: Order) {
        this.orderService.finish(order.orderId).subscribe(res => {
            if (res) {
                order.orderStatus = res.orderStatus;
            }
        })
    }

    selectChangeEventHandler (event:any){
        this.selectedDate=event.target.value;
        console.log(this.selectedDate);
    }

    // convertDateToString(dateToBeConverted: string) {
    //     return moment(dateToBeConverted, "YYYY-MM-DD HH:mm:ss").format("DD-MMM-YYYY");
    //     }

    ngOnDestroy(): void {
    }

}
