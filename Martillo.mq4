//+------------------------------------------------------------------+
//|                                                     Martillo.mq4 |
//|                                                       Ramón Ruiz |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Ramón Ruiz"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//parametros

input double porc_spike = 0.7;
input int    min_distancia = 0;

//variables globales

datetime time = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
//---
   if (Time[0]!=time){
   
      if (spikeArriba()){
         //operaciones de entrada sell
         Print("Patrón Martillo modo SELL. Time: "+Time[1]);
      }else if (spikeAbajo()){
         //operaciones de entrada buy
         Print("Patrón Martillo modo BUY. Time: "+Time[1]);
      }
      time = Time[0];
   }
}
//+------------------------------------------------------------------+

bool spikeArriba(){

   double ref = 0;
   
   if (Close[1]>=Open[1]){
      ref = Close[1];
   }else{
      ref = Open[1];
   }
   
   if (((High[1]-ref)/(High[1]-Low[1]))>=porc_spike && (High[1]-Low[1])>min_distancia){
      return true;
   }
   
   return false;

}

bool spikeAbajo() {

   double ref = 0;
   
   if (Close[1]<=Open[1]){
      ref = Close[1];
   }else{
      ref = Open[1];
   }
   
   if (((ref-Low[1])/(High[1]-Low[1]))>=porc_spike && (High[1]-Low[1])>min_distancia){
      return true;
   }
   
   return false;

}