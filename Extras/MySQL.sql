create database shopforhome_db;
use shopforhome_db;
CREATE TABLE cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
);


CREATE TABLE discount
(
    id character varying(255) NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
);

CREATE TABLE product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) ,
    category_type integer,
    create_time timestamp ,
    update_time timestamp ,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
);

ALTER TABLE `product_category` 
CHANGE COLUMN `category_id` `category_id` INT NOT NULL AUTO_INCREMENT ;


CREATE TABLE product_info
(
    product_id character varying(255)  NOT NULL,
    product_name character varying(255)  NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_stock integer NOT NULL,
    product_description character varying(255) ,
     product_icon character varying(255) , 
     product_status integer DEFAULT 0,
    category_type integer DEFAULT 0,
    create_time timestamp ,
    update_time timestamp ,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
);

CREATE TABLE users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) ,
    email character varying(255) ,
    name character varying(255) ,
    password character varying(255) ,
    phone character varying(255) ,
    role character varying(255) ,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
);

ALTER TABLE `users` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) ,
    buyer_email character varying(255) ,
    buyer_name character varying(255) ,
    buyer_phone character varying(255) ,
    create_time timestamp,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
);

ALTER TABLE `order_main` 
CHANGE COLUMN `order_id` `order_id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE product_in_order
(
    id bigint NOT NULL AUTO_INCREMENT,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255)  NOT NULL,
    product_icon character varying(255) ,
    product_id character varying(255) ,
    product_name character varying(255) ,
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        ,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
);



CREATE TABLE wishlist
(
    id bigint NOT NULL AUTO_INCREMENT,
    created_date timestamp ,
    user_id bigint,
    product_id character varying(255),
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_wish_Fkey FOREIGN KEY (user_id)
        REFERENCES users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE `discount`
ADD COLUMN user_email VARCHAR(255);

ALTER TABLE `discount` 
ADD INDEX `user_email_fkey_idx` (`user_email` ASC) VISIBLE;
;
ALTER TABLE `discount` 
ADD CONSTRAINT `user_email_fkey`
  FOREIGN KEY (`user_email`)
  REFERENCES `users` (`email`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `discount` 
DROP PRIMARY KEY;
;

ALTER TABLE `discount` 
ADD COLUMN `coupon` VARCHAR(255) NULL AFTER `user_email`,
CHANGE COLUMN `id` `id` BIGINT NOT NULL ,
ADD PRIMARY KEY (`id`);
;

ALTER TABLE `discount` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



INSERT INTO product_category VALUES (1, 'Bedroom', 0, '2022-08-10 19:03:26', '2022-08-10 19:03:26');
INSERT INTO product_category VALUES (2, 'Living', 1, '2022-08-10 19:03:27', '2022-08-10 19:03:27');
INSERT INTO product_category VALUES (3, 'Dinning', 2, '2022-08-10 19:03:27', '2022-08-10 19:03:27');
INSERT INTO product_category VALUES (4, 'Office', 3, '2022-08-10 19:03:28', '2022-08-10 19:03:28');

INSERT INTO product_info VALUES ('B01','ORNATE QUEEN SIZE BED',22900,35,'This ornate bed with a melamine finish is what you need if you want to instantly enhance the interiors of your bedroom.','/assets/images/B01.jpg',0,0,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('B02','CARVIN HYDRAULIC KING SIZE BED',42900,50,'This sturdy king-size bed is a must-have for your room if you’re looking for a bed that also is durable','/assets/images/B02.jpg',0,0,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('B03','FELICIA DRESSING TABLE',15999,100,'This minimalistic design dressing table is what you need for your room to dress in elegance.','/assets/images/B03.jpg',0,0,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('B04','WINCHESTER 4 DOOR WARDROBE',44900,29,'Melamine-faced engineered wood.','/assets/images/B04.jpg',0,0,'2022-08-10 19:03:26','2022-08-10 19:03:26');

INSERT INTO product_info VALUES ('L01','COFFEE TABLE',5290,78,'The unique colour of this coffee table enhances the interiors of your room','/assets/images/L01.jpg',0,1,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('L02','AUDIO/VIDEO RACK',9990,85,'Knockdown Design, Can Accomadate upto 55`` TV size','/assets/images/L02.jpg',0,1,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('L03','SHOE RACK',7990,67,'The size can fit any compact spaces so go ahead and buy it with confidence.','/assets/images/L03.jpg',0,1,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('L04','CORNER STAND',3990,88,'Knockdown Design, Can Accomodate 8 - 10 pairs of Shoes and Slippers of various Sizes','/assets/images/L04.jpg',0,1,'2022-08-10 19:03:26','2022-08-10 19:03:26');

INSERT INTO product_info VALUES ('D01','NEVADA 7 PIECES DINNING SET',75900,52,'Knockdown and Ergonomical Design','/assets/images/D01.jpg',0,2,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('D02','ATLANTA 7 PIECES DINNING SET',39900,103,'Lacquered Finish','/assets/images/D02.jpg',0,2,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('D03','MEOLEE 5 PIECES DINNING SET',21900,90,'Tempered glass faced and metal legs','/assets/images/D03.jpg',0,2,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('D04','DINNING CABINET',22900,200,'Unique design storage with lock-in bottom-hinged storage.','/assets/images/D04.jpg',0,2,'2022-08-10 19:03:26','2022-08-10 19:03:26');

INSERT INTO product_info VALUES ('O01','EXECUTIVE TABLE SET',14990,80,'Knockdown Design','/assets/images/O01.jpg',0,3,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('O02','RUBEN EXECUTIVE TABLE SET',29900,99,'Knockdown Design,side storage,1 drawer,1 filing drawer','/assets/images/O02.jpg',0,3,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('O03','CUPBOARD',19900,500,'This cupboard with glass doors is suitable for any space whether it is your office or home.','/assets/images/O03.jpg',0,3,'2022-08-10 19:03:26','2022-08-10 19:03:26');
INSERT INTO product_info VALUES ('O04','STUDY DESK',6990,90,' Knockdown Design,folding flap,shelfs and storage space','/assets/images/O04.jpg',0,3,'2022-08-18 19:03:26','2022-08-10 19:03:26');

INSERT INTO users VALUES (1, true, 'MALKAPURAM, VISAKHAPATNAM', 'admin@gmail.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');




