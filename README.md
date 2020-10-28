

## Features of our website

considerate, scalable, secure

> You'll see what I mean by that after the pre.

<img src="/Users/wangyunkun/Desktop/小学期前端/e-commerce/doc/front-end functions.png" alt="front-end functions" style="zoom:%;" />

> In this website, we have implemented customer registration and login, showcase the hardware 
>
> product and specification, customizing configurations and accessories, purchasing the customized 
>
> product, review purchases(orders). 
>
> In this website, purchases can be edited and canceled, personal information can be modified, and 
>
> we have a page showing the historical purchase statistics. 
>
> In addition, we have product comment module, categories module, product searching, sorting 
>
> module and all the other interesting functions waiting for you to find out!

## Product-Cart-Order purchase process

### Product selection 

accessory

configuration

categories

comment

### Cart's usage design

storage/dump

### Order statistics management interface

3 Order statuses

sales volume

inventory number

#### Inventory Stock

Triple detection to prevent inventory 

> One of the most important features that distinguishes us from the other groups is that our product inventory is secured. We can handle a certain degree of concurrency. In this website, the number of the product that you buy, there's no possibility that it will overflows the inventory num of the product. You can say that our product is **Thread safe**. I'll show you how it works.
>
> ...
>
> I'm not bragging, but I honestly think that not many of the other groups can do this. (back-end database)
>
> I mean, if you seriously want to put one of  the websites online, put into actual use, there is no way you can avoid considering the inventory security of the product. I feel like a lot of the other group, superficial front-end design, this website can guarantee the security of the product inventory. 
>
> From this sense, if you're about to choose only one website among us, and to put into your business use, we are the one.



## Webpage Layout design

Paging

Sorting

Searching

Recommendation



## User-Information-management

Login-logout

register

Modify-information





> All the functions are explained elaborately in the report, so here I wanna just talk about what makes our website stand out, and what's so great with our website.

## Security-Scalability

#### Inventory Stock

Triple detection mechanism 

> One of the most important features that distinguishes us from the other groups is that our product inventory is secured. 
>
> If you're trying to sell something, you need to make sure you have enough inventory for to sell.
>
> In this website, we have a **Triple detection mechanism** to prevent a customer from buying a number of products that overflows the inventory. I'll show you how it works.
>
> ...

 You can say that our product is "**Thread safe**". We can handle a certain degree of concurrency. 



> //I'm not bragging, but I honestly think that not many of the other groups can do this. (back-end database)
>
> //I mean, if you seriously want to put one of  the websites online, put into actual use, there is no way you can avoid //considering the inventory security of the product. 
>
> I feel like a lot of the other group, superficial front-end design, when they didn't even take inventory management into account, <u>this</u> website can guarantee the security of <u>your</u> product inventory. 
>
> From this sense, if you're about to choose only one website among us, and to put into your business use, we are the one.



Exception handler webpage

> This is another function that I believe not many of the other groups are capable of. 
>
> It is inevitable that some error or exception will be thrown during the process of the website, especially in jsp website when we use session to communicate the information. For other group's website, if you encounter an error in your website, their webpage will be stuck, or will trigger some unexpected event. 
>
> But in our website, we have design a special exception handler page for this. I'll show you how it works.



Scalable back-end Spring Boot framework

> We are using a powerful javaweb framework. And the design pattern we applied in our website assure you with high scalability.
>
> If you wanna promote this website and add in more functions in it (in the future), the structure of our back-end codes will make sure you can do that effortless.