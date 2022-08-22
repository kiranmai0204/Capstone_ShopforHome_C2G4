import {Component, OnDestroy, OnInit} from '@angular/core';
// import {prod, products} from '../shared/mockData';
import {ProductService} from '../../services/product.service';
import {ActivatedRoute, Router} from '@angular/router';
import {Subscription} from "rxjs";
import { WishListService } from '../../services/wish-list.service';
import {JwtResponse} from '../../response/JwtResponse';
import {UserService} from '../../services/user.service';
import { CartService } from 'src/app/services/cart.service';


@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent implements OnInit, OnDestroy {


  title: string;
  page: any;
  private paramSub: Subscription;
  private querySub: Subscription;
  addedToWishlist: boolean = false;

  searchTerm:String = "";


  constructor(private productService: ProductService,
              private route: ActivatedRoute,
              private wishListService: WishListService,
              private userService:UserService,
              private cartService: CartService,
              private router:Router) {
                this.userSubscription = this.userService.currentUser.subscribe(user => this.currentUser = user);
  }

  currentUser: JwtResponse;
    userSubscription: Subscription;



  ngOnInit() {
    this.querySub = this.route.queryParams.subscribe(() => {
      this.update();
    });
    this.paramSub = this.route.params.subscribe(() => {
      this.update();
    });


    this.route.params.subscribe(params => {
      if(params['searchTerm'])
        this.searchTerm=params['searchTerm'];
    })


  }


  search():void{
    if(this.searchTerm)
    this.router.navigateByUrl('/search/' + this.searchTerm)
  }

  ngOnDestroy(): void {
    this.querySub.unsubscribe();
    this.paramSub.unsubscribe();
  }

  update() {
    if (this.route.snapshot.queryParamMap.get('page')) {
      const currentPage = +this.route.snapshot.queryParamMap.get('page');
      const size = +this.route.snapshot.queryParamMap.get('size');
      this.getProds(currentPage, size);
    } else {
      this.getProds();
    }
  }
  getProds(page: number = 1, size: number = 20) {
    if (this.route.snapshot.url.length == 1) {
      this.productService.getAllInPage(+page, +size)
        .subscribe(page => {
          this.page = page;
          this.title = 'Products';
        });
    } else { //  /category/:id
      const type = this.route.snapshot.url[1].path;
      this.productService.getCategoryInPage(+type, page, size)
        .subscribe(categoryPage => {
          this.title = categoryPage.category;
          this.page = categoryPage.page;
        });
    }

  }

  handleAddToWishList( productId){
    console.log("started");
    
    this.cartService.addToWishList(productId).subscribe(() => {
      this.addedToWishlist=true;
    }
    
    );

    console.log(this.addedToWishlist);
  }

  handleRemoveFromWishList( productId){
    this.wishListService.removeFromWishList(productId).subscribe(() => {
      this.addedToWishlist=false;
    }
    
    );
  }
  sortProductByPrice(option){
    
    if(option.value =='l2h'){
      this.page.content.sort((a, b) => Number(a.productPrice) - Number(b.productPrice));
    }else if(option.value =='h2l'){
      this.page.content.sort((a, b) => Number(b.productPrice) - Number(a.productPrice));
    }
 }


}
