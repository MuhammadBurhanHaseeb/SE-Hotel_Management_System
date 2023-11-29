import 'package:flutter/material.dart';

class CurrentOrderInfo{
  String name;
  num price;
  int bedrooms;
  int bathrooms;
  String checkIn;
  String checkOut;
  int noOfDays;
  num totalPrice;
  int noOfGuests;

  CurrentOrderInfo(this.name,this.price,this.bedrooms,this.bathrooms,this.checkIn,this.checkOut,this.noOfDays,this.totalPrice,this.noOfGuests);

}
CurrentOrderInfo currentOrderGloabl = CurrentOrderInfo('',0,0,0,'','',0,0,0);